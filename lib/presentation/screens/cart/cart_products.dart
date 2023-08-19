import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/screens/description/description.dart';

import '../../../model/product_model.dart';
import '../../../services/controllers/cart_controller.dart';
import '../../constant/colors.dart';
import '../../generalwidgets/loader.dart';
import '../../generalwidgets/text.dart';
import '../../uimodels/prod_model.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cart = context.watch<CartProvider>();
    return ListView.builder(
        itemCount: cart.cartProducts.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (c, i) {
          ProductDatum prod = cart.cartProducts[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CartCard(
              product: prod,
            ),
          );
        });
  }
}

class CartCard extends StatelessWidget {
  final ProductDatum product;
  const CartCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    CartProvider action = Provider.of<CartProvider>(context, listen: false);
    return InkWell(
      onTap: () => showDiscription(context, product),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                child: OverflowBox(
                  minWidth: 70,
                  minHeight: 0.0,
                  maxWidth: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: product.productUnit!.photo ??
                        "",
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
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column(
              children: [
                InkWell(
                    onTap: () => CartController.deleteAndSaveCartItem(
                        context, product.id!),
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
