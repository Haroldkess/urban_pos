import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:salesapp/model/shop_settings_model.dart';
import '../api_url.dart';
import '../backoffice/db.dart';
import 'login_controller.dart';

class ShopSettingsController {
  static Future addShopSettingsOffline(context) async {
    ShopSettingsProvider set = Provider.of(context, listen: false);
    LoginProvider login = Provider.of(context, listen: false);
    var data = await Database.read(Database.settingKey);
 //   consoleLog(data.toString());
    var decode = await jsonDecode(jsonEncode(data));
   try{
     var existingData = ShopSettingsModel.fromJson(decode);
    set.addShopSetting(existingData);
   }catch(e){
   // await makeRequest(context, token, login.shopModel.data.user.s)
   }
  }

  static Future makeRequest(context, token, id) async {
    String url = "${Api.baseUrl}${Api.settings}$id";
    ShopSettingsProvider set = Provider.of(context, listen: false);

    ShopId body = ShopId(shopId: id);

    http.Response? response = await RequestData.postApi(url, token, body);
    if (response == null) {
    } else if (response.statusCode == 200) {
    //  consoleLog("successful");
      var jsonData = jsonDecode(response.body);
      //consoleLog(jsonData.toString());
      var incomingData = ShopSettingsModel.fromJson(jsonData);

      Database.create(Database.settingKey, jsonData);
      var data = await Database.read(Database.settingKey);
      var decode = await jsonDecode(jsonEncode(data));
      var existingData = ShopSettingsModel.fromJson(decode);
      set.addShopSetting(existingData);
    } else {}
  }
}

class ShopSettingsProvider extends ChangeNotifier {
  ShopSettingsModel settings = ShopSettingsModel();

  void addShopSetting(ShopSettingsModel setting) {
    settings = setting;
   
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
