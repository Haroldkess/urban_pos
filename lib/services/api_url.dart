import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {


  static const baseUrl = "https://testapi.shopurban.co/";
  static const login = "api/desktop/shop/user/login";
  static const products = "api/desktop/shop/product/all";
  static const settings = "api/desktop/shop/dashboard?shop_id=";
  static const categories = "api/oga/product/category/index?shop_id=";
  static const uploadOrders = "api/desktop/shop/order/upload";
  static const customers = "api/oga/shop/customer/index";


}

String header = "application/json";

class RequestData {
  static Future<http.Response?> postApi(
      [String? url, String? token, dynamic body, bool? isUpload]) async {
    http.Response? response;
    try {
      if (token == null) {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
              },
              body: jsonEncode(body.toJson()),
            )
            .timeout(const Duration(seconds: 20));
      } else {
        response = await http
            .post(
              Uri.parse(url!),
              headers: {
                HttpHeaders.contentTypeHeader: header,
                //   'Content-Type': 'application/json',
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
              body: isUpload == true
                  ? jsonEncode(body.toJson())
                  : jsonEncode(body.toJson()),
            )
            .timeout(const Duration(seconds: 20));
      }

      log(response.body);
    } catch (e) {
      response = null;
      consoleLog(e.toString());
    }
    return response;
  }

  static Future<http.Response?> getApi([
    String? url,
    String? token,
  ]) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url!),
        headers: {
          HttpHeaders.contentTypeHeader: header,
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      consoleLog(response.body);
    } catch (e) {
      response = null;
      consoleLog(e.toString());
    }
    return response;
  }

  static Future put() async {}

  static Future delete() async {}
}

void consoleLog(String val) {
  return debugPrint(val);
}
