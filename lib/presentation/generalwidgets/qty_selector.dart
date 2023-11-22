import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/uimodels/desription_model.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/controllers/operations.dart';
import '../../model/product_model.dart';

class QuantitySelector extends StatelessWidget {
  String? fieldName;
  ProductDatum product;
  List<ShopProductWholesalePrice>? pricing;
  ShopProductWholesalePrice? altPrice;

  String? name;

  QuantitySelector({
    Key? key,
    this.fieldName,
    required this.product,
    this.pricing,
    this.name,
    this.altPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiProvider qty = context.watch<UiProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              text: fieldName ?? "",
              size: 12,
              fontWeight: FontWeight.w600,
            ),
            GetBuilder<DescriprionController>(
                init: DescriprionController(),
                builder: (wholeQty) {
                  int finalQty = 0;
                  wholeQty.sales.forEach((element) {
                    finalQty += element.qty!.value;
                  });
                  // wholeQty.sales.where((p0) => p0.selected!.value == true).toList().first.qty!.value
                  return AppText(
                    text:
                        "${(product.stockCount! - (wholeQty.sales.where((p0) => p0.selected!.value == true).toList().isEmpty ? qty.qty : finalQty))} items left",
                    size: 12,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#669798"),
                  );
                })
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: HexColor("#DFE5F3")),
                borderRadius: const BorderRadius.all(Radius.circular(11)),
                shape: BoxShape.rectangle),
            height: 55,
            width: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        if (DescriprionController.instance.sales.isEmpty) {
                          List<ShopProductWholesalePrice> priceType = pricing!
                              .where((element) => element.name == name)
                              .toList();

                          // if ((qty.qty - priceType.first.wholesaleQuantity!) >=
                          //     product.stockCount!) return;

                          if (priceType.isNotEmpty) {
                            if ((qty.qty -
                                    priceType.first.wholesaleQuantity!) >=
                                product.stockCount!) return;
                            Operations.addQAty(
                                context,
                                false,
                                priceType.first.wholesaleQuantity,
                                priceType.first.price);
                          } else {
                            if (qty.qty >= product.stockCount!) return;
                            Operations.addQAty(
                                context, false, 1, product.sellPrice);
                          }
                        } else {
                          List<SalesModel> find = DescriprionController
                              .instance.sales
                              .where(
                                  (element) => element.selected!.value == true)
                              .toList();
                          log(find.length.toString());
                          int wholeQty = DescriprionController.instance.sales
                                  .where((element) =>
                                      element.selected!.value == true)
                                  .toList()
                                  .isEmpty
                              ? qty.qty
                              : DescriprionController.instance.sales
                                  .where((element) =>
                                      element.selected!.value == true)
                                  .toList()
                                  .first
                                  .qty!
                                  .value;

                          if (find.isNotEmpty) {
                            if ((wholeQty - altPrice!.wholesaleQuantity!) >=
                                product.stockCount!) return;

                            DescriprionController.instance.addQtySale(
                                find.first.wholeSale!.id!,
                                find.first.wholeSale!.wholesaleQuantity!,
                                false,
                                product.stockCount!);
                          }
                        }

                        // Operations.addQAty(
                        //     context,
                        //     false,
                        //     priceType.first.wholesaleQuantity,
                        //     priceType.first.price);

                        // List<ShopProductWholesalePrice> priceType = pricing!
                        //     .where((element) => element.name == name)
                        //     .toList();

                        // if (priceType.isNotEmpty) {
                        //   if ((qty.qty - priceType.first.wholesaleQuantity!) >=
                        //       product.stockCount!) return;
                        //   Operations.addQAty(
                        //       context,
                        //       false,
                        //       priceType.first.wholesaleQuantity,
                        //       priceType.first.price);
                        // } else {
                        //   if (qty.qty >= product.stockCount!) return;
                        //   Operations.addQAty(
                        //       context, false, 1, product.sellPrice);
                        // }
                      },
                      icon: const Icon(Icons.remove)),
                  GetBuilder<DescriprionController>(
                      init: DescriprionController(),
                      builder: (wholeQty) {
                        return AppText(
                          text: wholeQty.sales
                                  .where((element) =>
                                      element.selected!.value == true)
                                  .toList()
                                  .isEmpty
                              ? qty.qty.toString()
                              : wholeQty.sales
                                  .where((element) =>
                                      element.selected!.value == true)
                                  .toList()
                                  .first
                                  .qty!
                                  .value
                                  .toString(),
                          size: 12,
                          fontWeight: FontWeight.w600,
                        );
                      }),
                  IconButton(
                      onPressed: () {
                        if (DescriprionController.instance.sales.isEmpty) {
                          List<ShopProductWholesalePrice> priceType = pricing!
                              .where((element) => element.name == name)
                              .toList();

                          if (priceType.isNotEmpty) {
                            if ((qty.qty +
                                    priceType.first.wholesaleQuantity!) >=
                                product.stockCount!) return;
                            Operations.addQAty(
                                context,
                                true,
                                priceType.first.wholesaleQuantity,
                                priceType.first.price);
                          } else {
                            if (qty.qty >= product.stockCount!) return;

                            Operations.addQAty(
                                context, true, 1, product.sellPrice);
                          }
                        } else {
                          log("here");
                          List<SalesModel> find = DescriprionController
                              .instance.sales
                              .where(
                                  (element) => element.selected!.value == true)
                              .toList();
                          if (find.isNotEmpty) {
                            if ((qty.qty + altPrice!.wholesaleQuantity!) >=
                                product.stockCount!) return;

                            DescriprionController.instance.addQtySale(
                                find.first.wholeSale!.id!,
                                find.first.wholeSale!.wholesaleQuantity!,
                                true,
                                product.stockCount!);
                          }
                        }
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ))
      ],
    );
  }
}
