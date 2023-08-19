import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesModel {
  String? name;
  IconData? icon;

  CategoriesModel({this.icon, this.name});
}

List<CategoriesModel> category = [
  CategoriesModel(name: "Electronics & Gadgets", icon: Icons.phone_android),
  CategoriesModel(name: "Electronics & Gadgets", icon: Icons.kitchen),
  CategoriesModel(name: "Electronics & Gadgets", icon: Icons.handyman),
];
