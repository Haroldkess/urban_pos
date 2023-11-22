import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/api_url.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../../model/product_model.dart';

class TypeSelect extends StatelessWidget {
  final ProductDatum product;
  DescriprionController wholesale;
  TypeSelect({super.key, required this.product, required this.wholesale});

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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            children: [
              ...wholesale.sales.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: TypeSelectView(
                      name: e.wholeSale!.name ??
                          "Pack of ${e.wholeSale!.wholesaleQuantity}",
                      product: product,
                      data: e.wholeSale,
                      isMoreThanOne: true,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class TypeSelectView extends StatelessWidget {
  final String name;
  final ProductDatum product;
  ShopProductWholesalePrice? data;
  bool isMoreThanOne;

  TypeSelectView(
      {super.key,
      required this.name,
      required this.product,
      this.data,
      required this.isMoreThanOne});

  @override
  Widget build(BuildContext context) {
    UiProvider ui = context.watch<UiProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {
          if (isMoreThanOne) {
            DescriprionController.instance.selectPrice(data!.id!);
          }
          //  print(product.shopProductWholesalePrices!.last.price);
          Operations.addType(context, name);
        },
        child: isMoreThanOne
            ? GetBuilder<DescriprionController>(
                init: DescriprionController(),
                builder: (selected) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: selected.sales
                                    .where((p0) => p0.wholeSale!.id == data!.id)
                                    .first
                                    .selected!
                                    .value
                                ? HexColor("#849BD3")
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(6.0),
                        color: selected.sales
                                .where((p0) => p0.wholeSale!.id == data!.id)
                                .first
                                .selected!
                                .value
                            ? HexColor("#FFFFFF")
                            : Colors.transparent),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: AppText(
                        text: name,
                        color: HexColor("#667085"),
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              )
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: ui.type == name
                            ? HexColor("#849BD3")
                            : Colors.transparent),
                    borderRadius: BorderRadius.circular(6.0),
                    color: ui.type == name
                        ? HexColor("#FFFFFF")
                        : Colors.transparent),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
