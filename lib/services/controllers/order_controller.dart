import 'dart:convert';
import 'dart:developer';
import 'dart:math' as rand;
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/model/cart_model.dart';
import 'package:salesapp/model/order_model.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/generalwidgets/banner.dart';
import 'package:salesapp/services/controllers/cart_controller.dart';
import 'package:salesapp/services/controllers/product_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/product_model.dart';
import '../../model/user_model.dart';
import '../../presentation/constant/colors.dart';
import '../../presentation/uiproviders/ui_provider.dart';
import '../api_url.dart';
import '../backoffice/db.dart';
import '../temps/temp_store.dart';
import 'login_controller.dart';

class MyCart {
  String? note;
  String? sn;
  int? qty;
  String? amount;

  MyCart({this.note, this.sn, this.qty, this.amount});
}

class OrderController {
  static Future addToOrders(context, String status, double amount,
      double custToPay, String customerName, String orderNum) async {
    //  print("---------------- $amount --------------");
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    OrderProvider orderProvider = Provider.of(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);
    LoginProvider userData = Provider.of(context, listen: false);
    ProductProvider product = Provider.of(context, listen: false);

    List<CartItem> cartItems = [];
    final orderId = DateTime.now().millisecondsSinceEpoch.toInt();
    final cartId = DateTime.now().millisecondsSinceEpoch.toInt();

    MyCart cartData = MyCart(
        note: ui.note,
        sn: ui.sn,
        qty: ui.qty,
        amount: ui.amount.isEmpty ? ui.descAmount.toString() : ui.amount);

    double totCost = 0;
    double totPrice = 0;
    int totQty = 0;

    List<OrdersData> test = [];
    await Future.forEach(cartProvider.cartProducts, (element) async {
      totCost += element.costPrice;
      totQty += element.qty!;
      totPrice += double.tryParse(element.newPrice!)!;
      CartItem item = CartItem(
          shopProductId: element.productId,
          price: element.newPrice!,
          quantity: element.qty,
          status: "true",
          content: element.otherDetails,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          costPrice: element.costPrice,
          shopProduct:
              ShopProduct(product: OrderProduct(name: element.product!.name)));
      cartItems.add(item);
    });

    OrdersData prod = OrdersData(
      id: orderId,
      orderNumber: orderNum,
      userId: userData.shopModel.data!.user!.id!,
      shopId: userData.shopModel.data!.shop!.id!,
      status: status,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      amount: amount,
      createdBy: userData.shopModel.data!.user!.id!,
      totalCostPrice: totCost,
      profit: amount - totCost,
      amountToPay: amount,
      amountPaid: custToPay,
      vatAmount: 0.0,
      customerName: customerName,
      channel: "Mobile",
      payments: [
        Payment(
            amount: custToPay,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isConfirmed: 1,
            paymentType: ui.paymentMethod,
            id: orderId,
            userId: userData.shopModel.data!.user!.id!,
            orderNumberTrack: orderNum)
      ],
      user: User(
        id: userData.shopModel.data!.user!.id!,
        surname: userData.shopModel.data!.user!.surname ?? "",
        firstName: userData.shopModel.data!.user!.firstName ?? "",
        otherName: userData.shopModel.data!.user!.otherName ?? "",
        username: userData.shopModel.data!.user!.username ?? "",
        email: userData.shopModel.data!.user!.email ?? "",
        gender: userData.shopModel.data!.user!.gender ?? "",
        contactNo: userData.shopModel.data!.user!.contactNo ?? "",
        language: userData.shopModel.data!.user!.language ?? "",
        expiry: userData.shopModel.data!.user!.expiry ?? DateTime.now(),
        emailVerifiedAt: userData.shopModel.data!.user!.emailVerifiedAt ?? "",
        phoneVerifiedAt: userData.shopModel.data!.user!.phoneVerifiedAt!,
        image: userData.shopModel.data!.user!.image ?? "",
        lastLoginAt:
            userData.shopModel.data!.user!.lastLoginAt ?? DateTime.now(),
        createdAt: userData.shopModel.data!.user!.createdAt!,
        updatedAt: userData.shopModel.data!.user!.updatedAt ?? DateTime.now(),
      ),
      cart: Cart(
          id: cartId,
          userId: userData.shopModel.data!.user!.id!,
          shopId: userData.shopModel.data!.shop!.id!,
          quantity: totQty,
          amount: totPrice,
          status: 1,
          isShopOwner: "true",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          createdFor: "",
          customerName: customerName,
          cartItems: cartItems),
    );

    // test.add(prod);
    //   consoleLog(cartProvider.cartProducts.first.qty.toString());
    // OrderModel orderModel = OrderModel(
    //   data: Data(data: test),
    // );
    //  var data = jsonDecode(jsonEncode(orderModel.toJson()));
    // log("----------------- ${data.toString()}");
    var fullCart = await orderProvider.putInOrder(prod);

    try {
      var finalProd = await product.editPrd(cartProvider.cartProducts);
      Database.create(Database.productKey, finalProd);
      var incomingData = ProductModel.fromJson(finalProd);
      product.addProd(incomingData);
      await ProductController.addProductOffline(context);
    } catch (e) {
      consoleLog(e.toString());
    }
    //   consoleLog(fullCart.toString());
    await saveOrderOffline(fullCart);
    CartController.deleteAll(context);
    // PageRouting.popToPage(context);
  }

  static Future addFromDraftToOrders(context, String status, double amount,
      double custToPay, String customerName, String id, String orderNum) async {
    // print("---------------- $amount --------------");
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    OrderProvider orderProvider = Provider.of(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);
    LoginProvider userData = Provider.of(context, listen: false);
    ProductProvider product = Provider.of(context, listen: false);
    List<CartItem> cartItems = [];
    final orderId = DateTime.now().millisecondsSinceEpoch.toInt();
    final cartId = DateTime.now().millisecondsSinceEpoch.toInt();

    MyCart cartData = MyCart(
        note: ui.note,
        sn: ui.sn,
        qty: ui.qty,
        amount: ui.amount.isEmpty ? ui.descAmount.toString() : ui.amount);

    double totCost = 0;
    double totPrice = 0;
    int totQty = 0;
    // String r = rand.Random().nextInt(999999).toString().padLeft(5, '0');
    // final orderNum =
    //     "000${product.shopProduct.first.shopId}${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}$r";
    List<OrdersData> test = [];
    await Future.forEach(
        cartProvider.draftList.where((element) => element.id == id).first.data!,
        (element) async {
      totCost += element.costPrice;
      totQty += element.qty!;
      totPrice += double.tryParse(element.newPrice!)!;
      var dis = double.tryParse(element.sellPrice.toString())! -
          double.tryParse(element.newPrice.toString())!;
      CartItem item = CartItem(
          shopProductId: element.productId,
          price: element.newPrice!,
          quantity: element.qty,
          status: "true",
          content: element.otherDetails,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          costPrice: element.costPrice,
          discount: dis.isNegative ? 0 : dis,
          shopProduct:
              ShopProduct(product: OrderProduct(name: element.product!.name)));
      cartItems.add(item);
    });

    OrdersData prod = OrdersData(
      id: orderId,
      orderNumber: orderNum,
      userId: userData.shopModel.data!.user!.id!,
      shopId: product.shopProduct.first.shopId,
      status: status,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      amount: amount,
      createdBy: userData.shopModel.data!.user!.id!,
      totalCostPrice: totCost,
      profit: amount - totCost,
      amountToPay: amount,
      amountPaid: custToPay,
      vatAmount: 0.0,
      customerName: customerName,
      channel: "Mobile",
      payments: [
        Payment(
            amount: custToPay,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isConfirmed: 1,
            paymentType: ui.paymentMethod,
            id: orderId,
            userId: userData.shopModel.data!.user!.id!,
            orderNumberTrack: orderNum)
      ],
      user: User(
        id: userData.shopModel.data!.user!.id!,
        surname: userData.shopModel.data!.user!.surname ?? "",
        firstName: userData.shopModel.data!.user!.firstName ?? "",
        otherName: userData.shopModel.data!.user!.otherName ?? "",
        username: userData.shopModel.data!.user!.username ?? "",
        email: userData.shopModel.data!.user!.email ?? "",
        gender: userData.shopModel.data!.user!.gender ?? "",
        contactNo: userData.shopModel.data!.user!.contactNo ?? "",
        language: userData.shopModel.data!.user!.language ?? "",
        expiry: userData.shopModel.data!.user!.expiry ?? DateTime.now(),
        emailVerifiedAt: userData.shopModel.data!.user!.emailVerifiedAt ?? "",
        phoneVerifiedAt: userData.shopModel.data!.user!.phoneVerifiedAt!,
        image: userData.shopModel.data!.user!.image ?? "",
        lastLoginAt:
            userData.shopModel.data!.user!.lastLoginAt ?? DateTime.now(),
        createdAt: userData.shopModel.data!.user!.createdAt!,
        updatedAt: userData.shopModel.data!.user!.updatedAt ?? DateTime.now(),
      ),
      cart: Cart(
          id: cartId,
          userId: userData.shopModel.data!.user!.id!,
          shopId: product.shopProduct.first.shopId,
          quantity: totQty,
          amount: totPrice,
          status: 1,
          isShopOwner: "true",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          createdFor: "",
          customerName: customerName,
          cartItems: cartItems),
    );

    // test.add(prod);

    // OrderModel orderModel = OrderModel(
    //   data: Data(data: test),
    // );
    //  var data = jsonDecode(jsonEncode(orderModel.toJson()));
    // log("----------------- ${data.toString()}");
    var fullCart = await orderProvider.putInOrder(prod);

    //  consoleLog(fullCart.toString());
    try {
      var finalProd = await product.editPrd(cartProvider.cartProducts);
      Database.create(Database.productKey, finalProd);
      var incomingData = ProductModel.fromJson(finalProd);
      product.addProd(incomingData);
      await ProductController.addProductOffline(context);
    } catch (e) {
      consoleLog(e.toString());
    }
    await saveOrderOffline(fullCart);
    CartController.deleteAndSaveDraftItem(context, id);
    // PageRouting.popToPage(context);
  }

  static Future deleteAndSaveOrderItem(context, int id) async {
    OrderProvider orderProvider = Provider.of(context, listen: false);
    var fullOrder = await orderProvider.removeFromOrders(id);
    //  consoleLog(fullOrder.toString());
    await saveOrderOffline(fullOrder);
  }

  static Future deleteAllAndSaveOrderItem([context]) async {
    if (context != null) {
      OrderProvider orderProvider = Provider.of(context, listen: false);
      var fullOrder = await orderProvider.removeAllOrders();
      //  consoleLog(fullOrder.toString());
      await saveOrderOffline(fullOrder);
    } else {
      OrderModel fullOrders = OrderModel(
        status: "",
        data: Data(data: []),
      );

      var data = jsonDecode(jsonEncode(fullOrders.toJson()));

      await saveOrderOffline(data);
    }
  }

  static Future saveOrderOffline(jsonData) =>
      Database.create(Database.ordersKey, jsonData);

  static Future getOrderInitData(context) async {
    var db = await Database.openDatabase();
    if (!db.containsKey(Database.ordersKey)) {
      return;
    }
    OrderProvider order = Provider.of(context, listen: false);
    var data = await Database.read(Database.ordersKey);
    //  consoleLog(data.toString());
    var decode = await jsonDecode(jsonEncode(data));
    var existingData = OrderModel.fromJson(decode);
    order.initializeOrder(existingData.data!.data!);
  }

  static Future<void> syncOrder([context]) async {
    UiProvider uiProvider = Provider.of<UiProvider>(context, listen: false);
    LoginProvider login = Provider.of(context, listen: false);
    ProductProvider product = Provider.of(context, listen: false);
    uiProvider.loadOrderUpload(true);

    try {
      if (product.shopProduct.first.shopId != null ||
          product.shopProduct.isNotEmpty) {
        await atemptLogin(context);
        uiProvider.loadOrderUpload(false);
      } else {}
      uiProvider.loadOrderUpload(false);
    } catch (e) {
      uiProvider.loadOrderUpload(false);
    }

    uiProvider.loadOrderUpload(false);
  }

  static Future makeRequest([token, id, context]) async {
    String url = Api.baseUrl + Api.uploadOrders;
    SharedPreferences pref = await SharedPreferences.getInstance();

    var db = await Database.openDatabase();
    if (!db.containsKey(Database.ordersKey)) {
      return;
    }

    var data = await Database.read(Database.ordersKey);

    var decode = await jsonDecode(jsonEncode(data));

    OrderModel dataToBeSent = OrderModel.fromJson(decode);
    if (dataToBeSent.data != null) {
      if (dataToBeSent.data!.data != null) {
        if (dataToBeSent.data!.data!.isEmpty) {
          return;
        }
      }
    }

    var hold = dataToBeSent.data!.data!.map((e) => jsonEncode(e));

    var decodeHold = hold.toString().split('(').last;

    var finalSplit = decodeHold.toString().split(')').first;

    var sendThis = "[$finalSplit]";
    var test = orderListFromJson(sendThis);

    OrderUploadModel body =
        OrderUploadModel(shopId: id, order: sendThis, channel: "mobile");

    http.Response? response = await RequestData.postApi(url, token, body, true);
    if (response == null) {
      consoleLog("failed null");
      if (context != null) {
        getOrderInitData(context);
        showToast("Order upload failed",
            context: context,
            backgroundColor: red,
            // textStyle: TextStyle(color: blue),
            duration: Duration(seconds: 5),
            position: StyledToastPosition.top);
      }
    } else if (response.statusCode == 200) {
      OrderModel fullOrders = OrderModel(
        status: "",
        data: Data(data: []),
      );

      var data = jsonDecode(jsonEncode(fullOrders.toJson()));
      saveOrderOffline(data);
      consoleLog("successful");

      if (context != null) {
        showToast("Order synced",
            context: context,
            backgroundColor: blue,
            // textStyle: TextStyle(color: blue),
            duration: Duration(seconds: 5),
            position: StyledToastPosition.top);
        await deleteAllAndSaveOrderItem(context);
        pref.setBool(TempStore.orderSentKey, true);
        await ProductController.syncProd(context);
      } else {
        await deleteAllAndSaveOrderItem();
        pref.setBool(TempStore.orderSentKey, true);
      }

      // var jsonData = jsonDecode(response.body);
      // log(jsonData.toString());
      // var incomingData = ProductModel.fromJson(jsonData);

      // Database.create(Database.productKey, jsonData);
      // var data = await Database.read(Database.productKey);
      // var decode = await jsonDecode(jsonEncode(data));
      // var existingData = ProductModel.fromJson(decode);
      // product.addProd(existingData);
    } else {
      consoleLog("failed else");
      if (context != null) {
        showToast("Order upload failed",
            context: context,
            backgroundColor: red,
            // textStyle: TextStyle(color: blue),
            duration: Duration(seconds: 5),
            position: StyledToastPosition.top);
      }
    }
  }

  static Future syncStatus(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(TempStore.orderSentKey)) {
      if (pref.getBool(TempStore.orderSentKey) == true) {
        inAppSnackBar(
            context, "Product not synced since last order upload", true,
            () async {
          await ProductController.syncProd(context);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });
      }
    }
  }

  static Future atemptLogin([context]) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String url = Api.baseUrl + Api.login;
    LoginModel body = LoginModel(
        contactNo: pref.getString(TempStore.phoneKey),
        password: pref.getString(TempStore.passwordKey),
        shopId: pref.getString(TempStore.shopIdKey));

    http.Response? response = await RequestData.postApi(url, null, body);
    if (response == null) {
    } else if (response.statusCode == 200) {
      consoleLog("successful");
      var jsonData = jsonDecode(response.body);
      var incomingData = ShopModel.fromJson(jsonData);
      // login.createShop(incomingData);

      Database.create(Database.userKey, jsonData);

      var data = await Database.read(Database.userKey);
      var decode = await jsonDecode(jsonEncode(data));
      var existingData = ShopModel.fromJson(decode);

      TempStore.storeToken(existingData.data!.token);

      pref.setString(TempStore.phoneKey, body.contactNo!);
      pref.setString(TempStore.passwordKey, body.password!);
      pref.setString(TempStore.shopIdKey, body.shopId!);
      pref.setString(
          TempStore.shopIdNumKey, existingData.data!.shop!.id.toString());
      pref.setBool(TempStore.isLoggedInKey, true);
      //  log(existingData.data!.token!);
      await makeRequest(existingData.data!.token,
          existingData.data!.shop!.id.toString(), context ?? context);
    } else {}
  }
}

class OrderProvider extends ChangeNotifier {
  OrderModel orderModel = OrderModel();

  List<OrdersData> orders = [];
  String orderSearch = "";
  void searchOrder(String name) {
    orderSearch = name;

    notifyListeners();
  }

  Future putInOrder(OrdersData product) async {
    orders.add(product);
    OrderModel fullCart = OrderModel(
      status: "success",
      data: Data(data: orders),
    );
    orderModel = fullCart;
    var data = jsonDecode(jsonEncode(orderModel.toJson()));

    notifyListeners();
    return data;
  }

  Future initializeOrder(List<OrdersData> data) async {
    orders = data;
    notifyListeners();
  }

  Future removeFromOrders(int id) async {
    orders.removeWhere((element) => element.id == id);
    OrderModel fullOrders = OrderModel(
      status: "success",
      data: Data(data: orders),
    );
    orderModel = fullOrders;
    var data = jsonDecode(jsonEncode(orderModel.toJson()));

    notifyListeners();

    return data;
  }

  Future removeAllOrders() async {
    orders.clear();
    orders = [];
    OrderModel fullOrders = OrderModel(
      status: "",
      data: Data(data: orders),
    );
    orderModel = fullOrders;
    var data = jsonDecode(jsonEncode(orderModel.toJson()));

    notifyListeners();

    return data;
  }
}

class OrderUploadModel {
  String? shopId;
  dynamic order;
  String channel;

  OrderUploadModel({this.shopId, this.order, required this.channel});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["shop_id"] = shopId;
    data["orders"] = order;
    data["channel"] = channel;
    return data;
  }
}
