import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/model/category_model.dart';
import 'package:salesapp/model/product_model.dart';
import 'package:http/http.dart' as http;
import '../api_url.dart';
import '../backoffice/db.dart';

class CategoryController {
  static Future addCategoryOffline (context) async {
     CategoryProvider cat = Provider.of(context, listen: false);
      var data = await Database.read(Database.categoryKey);
      //   consoleLog(data.toString());
      var decode = await jsonDecode(jsonEncode(data));
      var existingData = CategoryModel.fromJson(decode);
      cat.addCategory(existingData);

  }
  static Future makeRequest(context, token, id) async {
    String url = Api.baseUrl + Api.categories + id;
    CategoryProvider cat = Provider.of(context, listen: false);
    http.Response? response = await RequestData.getApi(url, token);
    if (response == null) {
    } else if (response.statusCode == 200) {
    //  consoleLog("successful");
      var jsonData = jsonDecode(response.body);
     // consoleLog(jsonData.toString());
      var incomingData = CategoryModel.fromJson(jsonData);

      Database.create(Database.categoryKey, jsonData);
      var data = await Database.read(Database.categoryKey);
      var decode = await jsonDecode(jsonEncode(data));
      var existingData = CategoryModel.fromJson(decode);
      cat.addCategory(existingData);
    } else {}
  }
}

class CategoryProvider extends ChangeNotifier {
  CategoryModel categoryModel = CategoryModel();

  void addCategory(CategoryModel cat) {
    categoryModel = cat;
    notifyListeners();
  }
}
