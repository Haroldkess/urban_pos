import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/model/customer_model.dart';
import 'package:salesapp/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/model/shop_settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api_url.dart';
import '../backoffice/db.dart';
import '../middleware/server_thread.dart';
import '../temps/temp_store.dart';
import 'login_controller.dart';

class CustomerController {
  static Future addShopCustomersOffline(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    CustomerProvider set = Provider.of(context, listen: false);
    LoginProvider login = Provider.of(context, listen: false);
    var data = await Database.read(Database.customerKey);

    var decode = await jsonDecode(jsonEncode(data));
    try {
      var existingData = CustomerModel.fromJson(decode);
      set.addCustomer(existingData);
    } catch (e) {
      // await makeRequest(context, token, login.shopModel.data.user.s)
    }
    //   consoleLog(data.toString());
    // if (data == null) {
    //   await makeRequest(context, pref.getString(TempStore.tokenKey),
    //       pref.getString(TempStore.shopIdNumKey));
    // } else {
    //   var decode = await jsonDecode(jsonEncode(data));
    //   try {
    //     var existingData = CustomerModel.fromJson(decode);
    //     set.addCustomer(existingData);
    //   } catch (e) {
    //     // await makeRequest(context, token, login.shopModel.data.user.s)
    //   }
    // }
  }

  static Future makeRequest(context, token, id) async {
    String url = "${Api.baseUrl}${Api.customers}?shop_id=$id";
    CustomerProvider set = Provider.of(context, listen: false);

    ShopId body = ShopId(shopId: id);

    http.Response? response = await RequestData.getApi(url, token);
    if (response == null) {
    } else if (response.statusCode == 200) {
      //  consoleLog("successful");
      var jsonData = jsonDecode(response.body);
      //consoleLog(jsonData.toString());
      var incomingData = CustomerModel.fromJson(jsonData);

      Database.create(Database.customerKey, jsonData);
      var data = await Database.read(Database.customerKey);
      var decode = await jsonDecode(jsonEncode(data));
      var existingData = CustomerModel.fromJson(decode);
      set.addCustomer(existingData);
    } else {}
  }
}

class CustomerProvider extends ChangeNotifier {
  CustomerModel customer = CustomerModel();

  void addCustomer(CustomerModel setting) {
    customer = setting;

    notifyListeners();
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
    return data;
  }
}
