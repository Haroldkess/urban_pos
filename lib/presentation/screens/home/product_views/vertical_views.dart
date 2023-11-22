import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/description/description.dart';
import 'package:salesapp/presentation/uimodels/prod_model.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/services/api_url.dart';
import 'package:salesapp/services/controllers/order_controller.dart';

import '../../../../model/product_model.dart';
import '../../../../services/controllers/new_operation.dart';
import '../../../../services/controllers/product_controller.dart';
import '../../../constant/colors.dart';
import '../../../generalwidgets/loader.dart';

class VerticalViews extends StatelessWidget {
  const VerticalViews({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider prod = context.watch<ProductProvider>();
    OrderController.syncStatus(context);
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
          // if (prod.isCat) {
          //   newProd.shuffle();
          // }

          return prod.isCat && newProd.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset("assets/icon/nodata.svg"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    AppText(
                      text: "No Data",
                      size: 18,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#475467"),
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: newProd.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (c, i) {
                    ProductDatum _prod = newProd[i];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ProdVerticalCard(
                        product: _prod,
                      ),
                    );
                  });
        });
  }
}

class ProdVerticalCard extends StatelessWidget {
  final ProductDatum product;
  const ProdVerticalCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await WholeSaleOperation.removeAndAddWholeSale(
            context, product.shopProductWholesalePrices, product);
        // print(product.product!.productCategory!.name!);
        showDiscription(context, product, true);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 80,
                width: 80,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(color: HexColor("#DFE5F3")),
                  borderRadius: BorderRadius.circular(9.5),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.productUnit!.photo ?? "",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const Center(child: Loader()),
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
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: AppText(
                      maxLines: 3,
                      text:
                          "${product.product!.name ?? ""} ${product.productUnit == null ? "" : product.productUnit!.slug ?? ""}",
                      color: HexColor("#101828"),
                      size: 14,
                      align: TextAlign.left,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  AppText(
                    text:
                        "₦${convertToCurrency(product.sellPrice!.toString())}",
                    color: HexColor("#1D2939"),
                    size: 14,
                    align: TextAlign.left,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: AppText(
              text: product.stockCount.toString(),
              color: HexColor("#039855"),
              size: 14,
              align: TextAlign.left,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
