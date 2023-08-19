import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/model/cart_model.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';

import '../../model/product_model.dart';
import '../../presentation/uiproviders/ui_provider.dart';
import '../backoffice/db.dart';

class MyCart {
  String? note;
  String? sn;
  int? qty;
  String? amount;

  MyCart({this.note, this.sn, this.qty, this.amount});
}

class CartController {
  static Future addToCart(context, ProductDatum product) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);
    List<ProductDatum> cartInfo = cartProvider.cartProducts
        .where((element) => product.id == element.id)
        .toList();
    MyCart cartData = MyCart(
        note: ui.note,
        sn: ui.sn,
        qty: ui.qty,
        amount: ui.amount.isEmpty ? ui.descAmount.toString() : ui.amount);

    if (cartInfo.isEmpty) {
      ProductDatum incoming = product;
      ProductDatum prod = incoming.copyWith(
          qty: cartData.qty,
          otherDetails: cartData.note,
          newPrice: cartData.amount!,
          serialNo: cartData.sn!);

      var fullCart = await cartProvider.putInCart(prod);
    //  consoleLog(fullCart.toString());
      await saveCartOffline(fullCart);
      PageRouting.popToPage(context);
    } else {
      ProductDatum incoming = product;
      ProductDatum prod = incoming.copyWith(
          qty: cartData.qty!,
          otherDetails: cartData.note,
          newPrice: cartData.amount!,
          serialNo: cartData.sn!);

      var fullCart = await cartProvider.replaceInCart(prod);
    //  consoleLog(fullCart.toString());
      await saveCartOffline(fullCart);
      PageRouting.popToPage(context);
    }
  }

  static Future deleteAndSaveCartItem(context, int id) async {
    CartProvider cartProvider = Provider.of(context, listen: false);
    var fullCart = await cartProvider.removeFromCart(id);
    //consoleLog(fullCart.toString());
    await saveCartOffline(fullCart);
  }

  static Future deleteAll(context) async {
    CartProvider cartProvider = Provider.of(context, listen: false);
    var fullCart = await cartProvider.clearCart();
    //consoleLog(fullCart.toString());
    await saveCartOffline(fullCart);
  }

  static Future saveCartOffline(jsonData) =>
      Database.create(Database.cartKey, jsonData);

  static Future getCartInitData(context) async {
    var db = await Database.openDatabase();
    if (!db.containsKey(Database.cartKey)) {
      return;
    }
    CartProvider cart = Provider.of(context, listen: false);
    var data = await Database.read(Database.cartKey);
   // consoleLog(data.toString());
    var decode = await jsonDecode(jsonEncode(data));
    var existingData = ProductModel.fromJson(decode);
    cart.initializeCart(existingData.data!);
  }

  // draft

  static Future addToDraftCart(context, ProductDatum product, String id) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);
    List<ProductDatum> cartInfo = cartProvider.draftList
        .where((element) => element.id == id)
        .toList()
        .first
        .data!
        .where((element) => product.id == element.id)
        .toList();

    MyCart cartData = MyCart(
        note: ui.note,
        sn: ui.sn,
        qty: ui.qty,
        amount: ui.amount.isEmpty ? ui.descAmount.toString() : ui.amount);

    if (cartInfo.isEmpty) {
      ProductDatum incoming = product;
      ProductDatum prod = incoming.copyWith(
          qty: cartData.qty,
          otherDetails: cartData.note,
          newPrice: cartData.amount!,
          serialNo: cartData.sn!);

      var fullCart = await cartProvider.putInDraftCart(prod, id);
    //  consoleLog(fullCart.toString());
      await saveDraftOffline(fullCart);
      PageRouting.popToPage(context);
    } else {
      ProductDatum incoming = product;
      ProductDatum prod = incoming.copyWith(
          qty: cartData.qty!,
          otherDetails: cartData.note,
          newPrice: cartData.amount!,
          serialNo: cartData.sn!);

      var fullCart = await cartProvider.replaceInDraft(prod, id);
    //  consoleLog(fullCart.toString());
      await saveDraftOffline(fullCart);
      PageRouting.popToPage(context);
    }
  }

  static Future saveToDraft(context, customerName) async {
    CartProvider cartProvider = Provider.of(context, listen: false);
    var fullDraft = await cartProvider.putInDraft(customerName);
    // log(fullDraft.toString());
    await saveDraftOffline(fullDraft);
    await getDraftInitData(context).whenComplete(() =>
        Future.delayed(const Duration(seconds: 1))
            .whenComplete(() => deleteAll(context)));
  }

  static Future deleteAndSaveCartDraftItem(context, id, draftId) async {
    CartProvider draft = Provider.of(context, listen: false);
    var fullCart = await draft.removeFromDraftCart(id, draftId);
    //consoleLog(fullCart.toString());
    await saveDraftOffline(fullCart);
  }

  static Future deleteAndSaveDraftItem(
    context,
    id,
  ) async {
    CartProvider draft = Provider.of(context, listen: false);
    var fullCart = await draft.removeFromDraft(id);
   // consoleLog(fullCart.toString());
    await saveDraftOffline(fullCart);
  }

  static Future saveDraftOffline(jsonData) =>
      Database.create(Database.draftKey, jsonData);

  static Future getDraftInitData(context) async {
    var db = await Database.openDatabase();
    if (!db.containsKey(Database.draftKey)) {
      return;
    }
    CartProvider draft = Provider.of(context, listen: false);
    var data = await Database.read(Database.draftKey);
  //  consoleLog(data.toString());
    var decode = await jsonDecode(jsonEncode(data));
    var existingData = DraftModel.fromJson(decode);
    draft.initializeDraft(existingData.data!);
  }
}

class CartProvider extends ChangeNotifier {
  CartModel cartModel = CartModel();

  List<ProductDatum> cartProducts = [];

  DraftModel draftModel = DraftModel();
  List<CartModel2> draftList = [];

  Future putInCart(ProductDatum product) async {
    cartProducts.add(product);
    CartModel fullCart = CartModel(
      status: "",
      message: "",
      success: true,
      data: cartProducts,
    );
    cartModel = fullCart;
    var data = jsonDecode(jsonEncode(cartModel.toJson()));

    notifyListeners();
    return data;
  }

  Future replaceInCart(ProductDatum product) async {
    for (var i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].id == product.id) {
        final int qty = product.qty! + cartProducts[i].qty!;
        final String price =
            "${double.tryParse(product.newPrice!)! + double.tryParse(cartProducts[i].newPrice!)!}";
        ProductDatum prod = product.copyWith(
          qty: qty,
          newPrice: price,
        );
        cartProducts.removeAt(i);
        cartProducts.insert(i, prod);
      }
    }

    CartModel fullCart = CartModel(
      status: "",
      message: "",
      success: true,
      data: cartProducts,
    );
    cartModel = fullCart;
    var data = jsonDecode(jsonEncode(cartModel.toJson()));

    notifyListeners();
    return data;
  }

  Future initializeCart(List<ProductDatum> data) async {
    cartProducts = data;
    notifyListeners();
  }

  Future removeFromCart(int id) async {
    cartProducts.removeWhere((element) => element.id == id);
    CartModel fullCart = CartModel(
      status: "",
      message: "",
      success: true,
      data: cartProducts,
    );
    cartModel = fullCart;
    var data = jsonDecode(jsonEncode(cartModel.toJson()));

    notifyListeners();

    return data;
  }

  Future clearCart() async {
    cartProducts.clear();

    cartProducts = [];
    CartModel fullCart = CartModel(
      status: "",
      message: "",
      success: true,
      data: cartProducts,
    );
    cartModel = fullCart;
    var data = jsonDecode(jsonEncode(cartModel.toJson()));

    notifyListeners();

    return data;
  }

  Future putInDraftCart(ProductDatum product, String id) async {
    draftList.where((element) => element.id == id).first.data!.add(product);
    notifyListeners();
    // CartModel2 fullCart = CartModel2(
    //   status: "",
    //   message: "",
    //   success: true,
    //   data: cartProducts,
    // );
    draftModel = DraftModel(
        status: "true",
        message: "saved to draft",
        success: true,
        data: draftList);

    var data = jsonDecode(jsonEncode(draftModel.toJson()));

    notifyListeners();
    return data;
  }

  Future removeFromDraftCart(id, draftId) async {
    draftList
        .where((element) => element.id == draftId.toString())
        .first
        .data!
        .removeWhere((element) => element.id.toString() == id.toString());
    DraftModel fullCart = DraftModel(
      status: "",
      message: "",
      success: true,
      data: draftList,
    );
    draftModel = fullCart;
    var data = jsonDecode(jsonEncode(draftModel.toJson()));
    notifyListeners();
    return data;
  }

  Future replaceInDraft(ProductDatum product, String id) async {
    for (var i = 0;
        i < draftList.where((element) => element.id == id).first.data!.length;
        i++) {
      if (draftList.where((element) => element.id == id).first.data![i].id ==
          product.id) {
        final int qty = product.qty! +
            draftList.where((element) => element.id == id).first.data![i].qty!;
        final String price =
            "${double.tryParse(product.newPrice!)! + double.tryParse(draftList.where((element) => element.id == id).first.data![i].newPrice!)!}";
        ProductDatum prod = product.copyWith(
          qty: qty,
          newPrice: price,
        );
        draftList.where((element) => element.id == id).first.data!.removeAt(i);
        draftList
            .where((element) => element.id == id)
            .first
            .data!
            .insert(i, prod);
      }
    }

    DraftModel fullCart = DraftModel(
      status: "",
      message: "",
      success: true,
      data: draftList,
    );
    draftModel = fullCart;
    var data = jsonDecode(jsonEncode(draftModel.toJson()));

    notifyListeners();
    return data;
  }

  Future initializeDraft(List<CartModel2> data) async {
    draftList = data;
    notifyListeners();
  }

  Future removeFromDraft(id) async {
    draftList.removeWhere((element) => element.id == id.toString());
    DraftModel fullCart = DraftModel(
      status: "",
      message: "",
      success: true,
      data: draftList,
    );
    draftModel = fullCart;
    var data = jsonDecode(jsonEncode(draftModel.toJson()));
    notifyListeners();
    return data;
  }

  Future putInDraft(String customer) async {
    String cartId = DateTime.now().millisecondsSinceEpoch.toString();
    CartModel2 cart = CartModel2(
        id: cartId,
        createdAt: DateTime.now(),
        customerName: customer,
        data: cartProducts);
    draftList.add(cart);

    DraftModel fullDraft = DraftModel(
        status: "true",
        message: "saved to draft",
        success: true,
        data: draftList);

    draftModel = fullDraft;

    var data = jsonDecode(jsonEncode(draftModel.toJson()));
    notifyListeners();
    return data;
  }
}
