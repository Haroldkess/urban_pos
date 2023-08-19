import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesapp/presentation/generalwidgets/button.dart';
import 'package:salesapp/services/api_url.dart';
import '../../../model/order_model.dart';
import '../../../services/controllers/operations.dart';
import '../../constant/colors.dart';
import '../../generalwidgets/text.dart';

class OrderDetails extends StatefulWidget {
  final OrdersData order;
  const OrderDetails({super.key, required this.order});
 
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}
class _OrderDetailsState extends State<OrderDetails> {
  final GlobalKey<ExpansionTileCardState> card = GlobalKey();
  bool show = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              info("Order no.", widget.order.orderNumber!),
              info("Sold by", widget.order.user!.username!),
              info("Payment status", widget.order.status!),
              info("Channel", widget.order.channel!),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Card(
          elevation: 0,
          shadowColor: HexColor("#3359B6"),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                ExpansionTileCard(
                  key: card,
                  elevation: 0,
                  baseColor: Colors.transparent,
                  onExpansionChanged: (val) {
                    setState(() {
                      show = val;
                    });
                    print(val);
                  },
                  // expandedColor: HexColor("#F9FAFB"),
                  contentPadding: EdgeInsets.zero,
                  trailing: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icon/down.svg",
                        color: HexColor("#3359B6"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      show
                          ? const SizedBox.shrink()
                          : AppText(
                              text: widget.order.cart!.quantity.toString(),
                              color: HexColor("#667085"),
                              size: 14,
                              fontWeight: FontWeight.w500,
                            ),
                    ],
                  ),

                  title: AppText(
                    text: "",
                    color: HexColor("#667085"),
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: show
                            ? "Products Ordered"
                            : widget.order.cart!.cartItems!.first.shopProduct ==
                                    null
                                ? ""
                                : widget.order.cart!.cartItems!.first
                                    .shopProduct!.product!.name!,
                        color: HexColor("#667085"),
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      show
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: 10,
                            ),
                      show
                          ? const SizedBox.shrink()
                          : AppText(
                              text: "Quantity",
                              color: HexColor("#667085"),
                              size: 14,
                              fontWeight: FontWeight.w500,
                            ),
                    ],
                  ),
                  children: [
                    ...widget.order.cart!.cartItems!.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    text: e.shopProduct!.product!.name == null
                                        ? ""
                                        : e.shopProduct!.product!.name!,
                                    color: HexColor("#667085"),
                                    size: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              info("Quantity", e.quantity!.toString()),
                            ],
                          ),
                        ))
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     AppText(
                //       text: order.cart!.cartItems!.first.shopProduct == null
                //           ? ""
                //           : order.cart!.cartItems!.first.shopProduct!.product!
                //               .name!,
                //       color: HexColor("#667085"),
                //       size: 14,
                //       fontWeight: FontWeight.w500,
                //     ),
                //     SvgPicture.asset(
                //       "assets/icon/down.svg",
                //       color: HexColor("#3359B6"),
                //     ),
                //   ],
                // ),
              ]),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              info("Sub Total",
                  "₦${convertToCurrency(widget.order.amount.toString())}"),
              info("Delivery Fee", "0"),
              info("VAT", "0"),
              info("Total",
                  "₦${convertToCurrency(widget.order.amountToPay.toString())}"),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        MyButton(
            backColor: Colors.white,
            onTap: () {
              Operations.shareFile(
                  context,
                  widget.order.customerName!,
                  widget.order.status!,
                  widget.order.orderNumber!,
                  widget.order.amount!,
                  "0.0",
                  "0.0",
                  widget.order.amountPaid!.toString(),
                  true,
                  widget.order.amountPaid!.toString());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.share,
                  size: 15,
                  color: HexColor("#3359B6"),
                ),
                const SizedBox(
                  width: 5,
                ),
                AppText(
                  text: "Share",
                  color: HexColor("#3359B6"),
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        MyButton(
            backColor: Colors.white,
            onTap: () async {
              Operations.openPdf(
                  context,
                  widget.order.customerName!,
                  widget.order.status!,
                  widget.order.orderNumber!,
                  widget.order.amount!,
                  "0.0",
                  "0.0",
                  widget.order.amountPaid!.toString(),
                  true,
                  widget.order.amountPaid!.toString());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icon/printer.svg",
                  color: HexColor("#3359B6"),
                ),
                const SizedBox(
                  width: 5,
                ),
                AppText(
                  text: "Print Invoice",
                  color: HexColor("#3359B6"),
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            )),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget info(String title, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: title,
            color: HexColor("#667085"),
            size: 14,
            fontWeight: FontWeight.w500,
          ),
          title == "Payment status"
              ? Container(
                  decoration: BoxDecoration(
                      color: HexColor("#ECFDF3"),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: AppText(
                      text: sub,
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#027A48"),
                    ),
                  ),
                )
              : AppText(
                  text: sub,
                  color: HexColor("#344054"),
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
        ],
      ),
    );
  }
}
