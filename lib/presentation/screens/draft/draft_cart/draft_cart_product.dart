import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/model/cart_model.dart';
import 'package:salesapp/presentation/screens/description/description.dart';

import '../../../../model/product_model.dart';
import '../../../../services/controllers/cart_controller.dart';
import '../../../../services/controllers/product_controller.dart';
import '../../../constant/colors.dart';
import '../../../generalwidgets/loader.dart';
import '../../../generalwidgets/text.dart';

class DraftCartProducts extends StatelessWidget {
  String id;
  DraftCartProducts({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    CartProvider draft = context.watch<CartProvider>();
    List<ProductDatum> prod = [];
    List<CartModel2> data =
        draft.draftList.where((element) => element.id == id).toList();
    if (data.isNotEmpty) {
      prod = data.first.data!;
    }
    return ListView.builder(
        itemCount: prod.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (c, i) {
          ProductDatum product = prod[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DraftCartCard(
              product: product,
              id: id,
            ),
          );
        });
  }
}

class DraftCartCard extends StatelessWidget {
  final ProductDatum product;
  final String id;
  const DraftCartCard({super.key, required this.product, required this.id});

  @override
  Widget build(BuildContext context) {
    CartProvider action = Provider.of<CartProvider>(context, listen: false);
    ProductProvider prod = context.watch<ProductProvider>();
    return InkWell(
      onTap: () {
        final getProForEdit = prod.shopProduct
            .where((element) => element.id == product.id)
            .toList();

        if (getProForEdit.isNotEmpty) {
          ProductDatum data = getProForEdit.first.copyWith(
              stockCount: getProForEdit.first.stockCount! - product.qty!);

          showDiscription(context, data, false, true, id);
        }
        //   showDiscription(context, product, true, id);
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
                  imageUrl: product.product!.photo ?? "",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const Center(child: Loader()),
                  errorWidget: (context, url, error) => CachedNetworkImage(
                    imageUrl: product.product!.photo ?? "",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const Center(child: Loader()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
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
                      text: product.product!.name!,
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
                    text: "₦${convertToCurrency(product.newPrice!.toString())}",
                    color: HexColor("#1D2939"),
                    size: 14,
                    align: TextAlign.left,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          product.attributes == 0 || product.attributes == null
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: AppText(
                                          text:
                                              "Single  X${product.attributes}",
                                          size: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ...product.shopProductWholesalePrices!.map(
                            (e) => e.wholesaleQuantity == 0 ||
                                    e.wholesaleQuantity == null
                                ? SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: AppText(
                                            text:
                                                "${e.name}  X${e.wholesaleQuantity}",
                                            size: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              children: [
                InkWell(
                    onTap: () => CartController.deleteAndSaveCartDraftItem(
                        context, product.id!, id),
                    child: SvgPicture.asset("assets/icon/trash.svg")),
                const SizedBox(
                  height: 20,
                ),
                AppText(
                  text: "x${product.qty}",
                  color: HexColor("#475467"),
                  size: 14,
                  align: TextAlign.left,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
