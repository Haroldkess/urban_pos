import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/services/controllers/category_controller.dart';
import 'package:salesapp/services/controllers/shop_settings_controller.dart';
import 'package:salesapp/services/temps/temp_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/uiproviders/ui_provider.dart';
import '../api_url.dart';
import '../backoffice/db.dart';
import 'customer_controller.dart';
import 'login_controller.dart';

class ProductController {
  static Future addProductOffline(context) async {
    ProductProvider product = Provider.of(context, listen: false);
    var data = await Database.read(Database.productKey);
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (data == null) {
      await makeRequest(context, pref.getString(TempStore.tokenKey),
          pref.getString(TempStore.shopIdNumKey));
    } else {
      var decode = await jsonDecode(jsonEncode(data));
      var existingData = ProductModel.fromJson(decode);
      product.addProd(existingData);
    }
    //  consoleLog(data.toString());
  }

  static Future<void> syncProd(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    UiProvider uiProvider = Provider.of<UiProvider>(context, listen: false);
    LoginProvider login = Provider.of(context, listen: false);
    ProductProvider product = Provider.of(context, listen: false);
    uiProvider.loadProducts(true);

    try {
      if (product.shopProduct.first.shopId != null ||
          product.shopProduct.isNotEmpty) {
        //   print("yo");
        await makeRequest(context, login.shopModel.data!.token,
                login.shopModel.data!.shop!.id.toString())
            .whenComplete(() => CategoryController.makeRequest(
                    context,
                    login.shopModel.data!.token,
                    login.shopModel.data!.shop!.id.toString())
                .whenComplete(() => ShopSettingsController.makeRequest(
                    context,
                    login.shopModel.data!.token,
                    login.shopModel.data!.shop!.id.toString())));
        CategoryController.makeRequest(context, login.shopModel.data!.token,
            login.shopModel.data!.shop!.id.toString());
        CustomerController.makeRequest(context, login.shopModel.data!.token,
            login.shopModel.data!.shop!.id.toString());
        pref.setBool(TempStore.orderSentKey, false);
        uiProvider.loadProducts(false);
      } else {
        //  print("yo");
      }
      uiProvider.loadProducts(false);
    } catch (e) {
      uiProvider.loadProducts(false);
    }

    uiProvider.loadProducts(false);
  }

  static Future makeRequest(context, token, id) async {
    String url = Api.baseUrl + Api.products;
    ProductProvider product = Provider.of(context, listen: false);

    ShopId body = ShopId(shopId: id);
    // consoleLog("start");
    http.Response? response = await RequestData.postApi(url, token, body);
    if (response == null) {
      // consoleLog("failed null");
    } else if (response.statusCode == 200) {
      //  consoleLog("successful");
      var jsonData = jsonDecode(response.body);
      consoleLog("prodsuctsss..." + jsonData.toString());
      var incomingData = ProductModel.fromJson(jsonData);

      Database.create(Database.productKey, jsonData);
      var data = await Database.read(Database.productKey);
      var decode = await jsonDecode(jsonEncode(data));
      var existingData = ProductModel.fromJson(decode);
      product.addProd(existingData);
    } else {
      //  consoleLog("failed else");
    }
  }
}

class ProductProvider extends ChangeNotifier {
  ProductModel productModel = ProductModel();

  List<ProductDatum> shopProduct = [];

  String filter = "";
  bool isCat = false;

  void addProd(ProductModel prod) {
    productModel = prod;
    shopProduct = prod.data!;
    notifyListeners();
  }

  void searchProd(String name, bool isWhat) {
    filter = name;
    isCat = isWhat;
    notifyListeners();
  }

  Future editPrd(List<ProductDatum> data) async {
    await Future.forEach(data, (element) async {
      List<ProductDatum> check = shopProduct
          .where((val) => val.id.toString() == element.id.toString())
          .toList();

      if (check.isNotEmpty) {
        if (shopProduct.where((x) => x.id == check.first.id).first.stockCount! -
                element.qty! <
            0) {
        } else {
          shopProduct.where((x) => x.id == check.first.id).first.stockCount =
              check.first.stockCount! - element.qty!;
        }
      }
    });

    ProductModel finalData =
        ProductModel(status: "", success: true, message: "", data: shopProduct);
    var returned = jsonDecode(jsonEncode(finalData.toJson()));
    addProd(finalData);

    notifyListeners();

    return returned;
    // shopProduct.where((element) => element.id.toString() == va..toString()).toList();
  }
}

class ShopId {
  String? shopId;

  ShopId({
    this.shopId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["shop_id"] = shopId;
    data["last_sync"] = "";
    return data;
  }
}
