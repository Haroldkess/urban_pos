import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';

class SalesModel {
  Rx<int>? qty = 0.obs;
  String? amount;
  int? id;
  Rx<TextEditingController> subAmount = TextEditingController().obs;
  ShopProductWholesalePrice? wholeSale;
  int initialQty;
  Rx<bool>? selected = false.obs;

  SalesModel(
      {required this.amount,
      required this.qty,
      required this.wholeSale,
      required this.id,
      required this.subAmount,
      required this.initialQty,
      this.selected});
}
