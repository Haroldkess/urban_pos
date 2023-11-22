import 'package:flutter/animation.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

Color drawerText = HexColor("#5F6B81");
Color blue = Colors.blue.shade900;
Color white = Colors.white;
Color red = Colors.redAccent;
Color green = Colors.green;
currencySymbol() {
  var format =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  return format.currencySymbol;
}

convertToCurrency( e) {
  String newStr = e.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[0]},");
  return newStr;
}
