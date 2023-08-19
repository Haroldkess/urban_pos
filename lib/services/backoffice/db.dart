import 'package:hive_flutter/adapters.dart';

class Database {
  static const databaseName = "urban";
  static const userKey = "user";
  static const productKey = "products";
  static const categoryKey = "productCategory";
  static const cartKey = "cart";
  static const ordersKey = "orders";
  static const settingKey = "settingKey";
  static const draftKey = "draft";
    static const customerKey = "customer";

  static Future initDatabase() async {
    await Hive.initFlutter(databaseName);
  }

  static Future<Box<dynamic>> openDatabase() async {
    var db = await Hive.openBox(databaseName);
    return db;
  }

  static Future create(key, dynamic data) async {
    var db = await openDatabase();
    await db.put(key, data);
  }

  static Future read(key) async {
    var db = await openDatabase();
    var data = db.get(key);

    return data;
  }

  static Future update(key, dynamic data) async {
    var db = await openDatabase();
    await db.put(key, data);
  }

  static Future delete(key) async {
    var db = await openDatabase();
    await db.delete(key);
  }
}
