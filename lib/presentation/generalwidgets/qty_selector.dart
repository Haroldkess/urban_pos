import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../model/product_model.dart';

class QuantitySelector extends StatelessWidget {
  String? fieldName;
  ProductDatum product;
  List<ShopProductWholesalePrice>? pricing;

  String? name;

  QuantitySelector({
    Key? key,
    this.fieldName,
    required this.product,
    this.pricing,
    this.name,
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
            AppText(
              text: "${(product.stockCount! - qty.qty)} items left",
              size: 12,
              fontWeight: FontWeight.w600,
              color: HexColor("#669798"),
            )
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
                        List<ShopProductWholesalePrice> priceType = pricing!
                            .where((element) => element.name == name)
                            .toList();

                        if (priceType.isNotEmpty) {
                          if ((qty.qty - priceType.first.wholesaleQuantity!) >=
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
                      },
                      icon: const Icon(Icons.remove)),
                  AppText(
                    text: qty.qty.toString(),
                    size: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                      onPressed: () {
                        List<ShopProductWholesalePrice> priceType = pricing!
                            .where((element) => element.name == name)
                            .toList();

                        if (priceType.isNotEmpty) {
                          if ((qty.qty + priceType.first.wholesaleQuantity!) >=
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
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
            ))
      ],
    );
  }
}
