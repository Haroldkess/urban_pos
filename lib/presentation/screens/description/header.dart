import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../model/product_model.dart';
import '../../constant/colors.dart';
import '../../generalwidgets/text.dart';
import '../../uimodels/prod_model.dart';

class DescriptionHeader extends StatelessWidget {
  final ProductDatum product;
  const DescriptionHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(color: HexColor("#DFE5F3")),
                borderRadius: BorderRadius.circular(9.5),
              ),
              child: CachedNetworkImage(
                imageUrl: product.productUnit!.photo ?? "",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 180),
                  child: AppText(
                    text: product.product!.name!,
                    color: HexColor("#101828"),
                    size: 14,
                    align: TextAlign.left,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                AppText(
                  text: "₦${convertToCurrency(product.sellPrice!.toString())}",
                  color: HexColor("#1D2939"),
                  size: 14,
                  align: TextAlign.left,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
