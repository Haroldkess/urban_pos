import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';

import '../../../model/order_model.dart';
import '../../../services/controllers/operations.dart';
import '../../generalwidgets/button.dart';
import '../../generalwidgets/text.dart';

class OrderPayment extends StatelessWidget {
  final OrdersData order;
  const OrderPayment({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var total = 0.0;
    order.payments!.forEach((val) {
      total += val.amount!.toDouble();
    });
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ...order.payments!.map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                        color: HexColor("#EAEFF7"),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          "assets/icon/cash.svg"),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: e.paymentType!,
                                  color: HexColor("#475467"),
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                AppText(
                                  text: Operations.convertDate(e.createdAt!)
                                      .toString(),
                                  color: HexColor("#667085"),
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            AppText(
                              text:
                                  "₦${convertToCurrency(e.amount!.toString())}",
                              color: HexColor("#344054"),
                              size: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        )),
        Container(
          height: 200,
          width: double.infinity,
          color: HexColor("#DFE5F3").withOpacity(.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    height: 95,
                    width: 315,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          info("Total Paid", total.toString()),
                          info("Amount Due", order.amountToPay.toString())
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: MyButton(
                    backColor: HexColor("#0A38A7"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: "Add Payment",
                          color: Colors.white,
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    )),
              ),
            ],
          ),
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
          AppText(
            text: "₦${convertToCurrency(sub)}",
            color: HexColor("#344054"),
            size: 14,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
