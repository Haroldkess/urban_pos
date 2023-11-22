import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/services/controllers/product_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../model/product_model.dart';
import '../../../constant/colors.dart';
import '../../../generalwidgets/loader.dart';
import '../../../generalwidgets/text.dart';
import '../../../uimodels/prod_model.dart';
import '../../description/description.dart';

class GridViews extends StatelessWidget {
  const GridViews({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider prod = context.watch<ProductProvider>();
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          List<ProductDatum> newProd = prod.isCat
              ? prod.shopProduct.where((element) {
                  return element.product!.productCategory == null
                      ? element.product!.id! < 0
                      : element.product!.productCategory!.name!
                          .toLowerCase()
                          .contains(prod.filter == "All products"
                              ? ""
                              : prod.filter.toLowerCase());
                }).toList()
              : prod.shopProduct.where((element) {
                  return element.product!.name!
                      .toLowerCase()
                      .contains(prod.filter.toLowerCase());
                }).toList();
          return GridView.builder(
              itemCount: newProd.length,
              physics: BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .62,
                crossAxisSpacing: 21,
                mainAxisSpacing: 21,
              ),
              itemBuilder: (c, i) {
                ProductDatum _prod = newProd[i];
                return ProdGridCard(
                  product: _prod,
                );
              });
        });
  }
}

class ProdGridCard extends StatelessWidget {
  final ProductDatum product;
  const ProdGridCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDiscription(context, product, true),
      child: Container(
        width: 173,
        height: 273,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 173,
              width: 173,
              decoration: BoxDecoration(
                border: Border.all(color: HexColor("#DFE5F3")),
                borderRadius: BorderRadius.circular(20.5),
              ),
              child: OverflowBox(
                minWidth: 0.0,
                minHeight: 0.0,
                maxWidth: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: product.productUnit!.photo ?? "",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const Center(child: Loader()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 173),
              child: AppText(
                text:
                    "${product.product!.name ?? ""} ${product.productUnit == null ? "" : product.productUnit!.slug ?? ""}",
                color: HexColor("#101828"),
                size: 14,
                align: TextAlign.left,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                AppText(
                  text: "In stock:",
                  color: HexColor("#667085"),
                  size: 12,
                  align: TextAlign.left,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  text: product.stockCount.toString(),
                  color: HexColor("#D92D20"),
                  size: 12,
                  align: TextAlign.left,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            AppText(
              text: "₦${convertToCurrency(product.sellPrice!.toString())}",
              color: HexColor("#1D2939"),
              size: 14,
              align: TextAlign.left,
              fontWeight: FontWeight.w800,
            ),
          ],
        ),
      ),
    );
  }
}
