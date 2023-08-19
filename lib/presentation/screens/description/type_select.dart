import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/api_url.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../../model/product_model.dart';

class TypeSelect extends StatelessWidget {
  final ProductDatum product;
  const TypeSelect({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 300,
        height: 44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: HexColor("#F2F4F7")),
        child: Row(
          children: [
            ...product.shopProductWholesalePrices!.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: TypeSelectView(
                        name: "Retail",
                        product: product,
                      ),
                    )
                  ]
                : product.shopProductWholesalePrices!.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: TypeSelectView(
                        name: e.name ?? "No name",
                        product: product,
                        data: e,
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}

class TypeSelectView extends StatelessWidget {
  final String name;
  final ProductDatum product;
  ShopProductWholesalePrice? data;

  TypeSelectView(
      {super.key, required this.name, required this.product, this.data});

  @override
  Widget build(BuildContext context) {
    UiProvider ui = context.watch<UiProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {
          print(product.shopProductWholesalePrices!.last.price);
          Operations.addType(context, name);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: ui.type == name
                      ? HexColor("#849BD3")
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(6.0),
              color:
                  ui.type == name ? HexColor("#FFFFFF") : Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: AppText(
              text: name,
              color: HexColor("#667085"),
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

List<String> type = ["Retail", "Pack of 4", "Dozen"];
