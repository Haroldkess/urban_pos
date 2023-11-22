import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/generalwidgets/banner.dart';
import 'package:salesapp/services/api_url.dart';
import 'package:salesapp/services/backoffice/db.dart';
import 'package:salesapp/services/controllers/category_controller.dart';
import 'package:salesapp/services/controllers/customer_controller.dart';
import 'package:salesapp/services/controllers/product_controller.dart';
import 'package:salesapp/services/controllers/shop_settings_controller.dart';
import 'package:salesapp/services/temps/temp_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';
import '../../presentation/functions/allNavigation.dart';
import '../../presentation/screens/home/home_screen.dart';
import 'cart_controller.dart';
import 'order_controller.dart';

class LoginController {
  static Future makeRequest(context) async {
    String url = Api.baseUrl + Api.login;
    LoginProvider login = Provider.of(context, listen: false);
    SharedPreferences pref = await TempStore.pref();

    if (pref.containsKey(TempStore.tokenKey)) {
      var data = await Database.read(Database.userKey);
      // consoleLog(data.toString());
      var decode = await jsonDecode(jsonEncode(data));
      var existingData = ShopModel.fromJson(decode);
      login.createShop(existingData);

      ProductController.addProductOffline(context);
      CategoryController.addCategoryOffline(context);
      ShopSettingsController.addShopSettingsOffline(context);
      CustomerController.addShopCustomersOffline(context);
      CartController.getCartInitData(context);
      CartController.getDraftInitData(context);
      OrderController.getOrderInitData(context);
      pref.setBool(TempStore.isLoggedInKey, true);
      PageRouting.removeAllToPage(context, const HomeScreen());

      //    log(existingData.data!.user!.username.toString());
    } else {
      LoginModel body = LoginModel(
          contactNo: login.phoneNumber,
          password: login.password,
          shopId: login.shopId);

      http.Response? response = await RequestData.postApi(url, null, body);
      if (response == null) {
      } else if (response.statusCode == 200) {
        //   consoleLog("successful");
        var jsonData = jsonDecode(response.body);
        var incomingData = ShopModel.fromJson(jsonData);
        // login.createShop(incomingData);

        Database.create(Database.userKey, jsonData);

        var data = await Database.read(Database.userKey);
        var decode = await jsonDecode(jsonEncode(data));
        var existingData = ShopModel.fromJson(decode);
        login.createShop(existingData);
        TempStore.storeToken(login.shopModel.data!.token);
        await ProductController.makeRequest(
            context,
            login.shopModel.data!.token,
            login.shopModel.data!.shop!.id!.toString());
        await CategoryController.makeRequest(
            context,
            login.shopModel.data!.token,
            login.shopModel.data!.shop!.id!.toString());
        await ShopSettingsController.makeRequest(
            context,
            login.shopModel.data!.token,
            login.shopModel.data!.shop!.id!.toString());
        await CustomerController.makeRequest(
            context,
            login.shopModel.data!.token,
            login.shopModel.data!.shop!.id!.toString());
        pref.setString(TempStore.phoneKey, body.contactNo!);
        pref.setString(TempStore.passwordKey, body.password!);
        pref.setString(TempStore.shopIdKey, body.shopId!);
        pref.setString(
            TempStore.shopIdNumKey, login.shopModel.data!.shop!.id!.toString());
        pref.setBool(TempStore.isLoggedInKey, true);

        PageRouting.pushToPage(context, const HomeScreen());
      } else {
        var jsonData = jsonDecode(response.body);

        showBanner(jsonData["message"], red, context);
      }
    }
  }
}

class LoginProvider extends ChangeNotifier {
  ShopModel shopModel = ShopModel();
  String? shopId;
  String? phoneNumber;
  String? password;

  Future createShop(ShopModel shop) async {
    shopModel = shop;
    notifyListeners();
  }

  Future<void> addDetails(String id, phone, pass) async {
    shopId = id;
    phoneNumber = phone;
    password = pass;

    notifyListeners();
  }
}

class LoginModel {
  String? contactNo;
  String? password;
  String? shopId;

  LoginModel({
    this.contactNo,
    this.password,
    this.shopId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["contact_no"] = contactNo;
    data["password"] = password;
    data["shop_id"] = shopId;

    return data;
  }
}
