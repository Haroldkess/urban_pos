import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/screens/checkout/checkout_screen.dart';
import '../../../../model/cart_model.dart';
import '../../../../services/controllers/cart_controller.dart';
import '../../../generalwidgets/button.dart';
import '../../../generalwidgets/text.dart';

class DraftCartPrice extends StatelessWidget {
  final String customerName;
  final String id;
  const DraftCartPrice(
      {super.key, required this.customerName, required this.id});

  @override
  Widget build(BuildContext context) {
    CartProvider draft = context.watch<CartProvider>();
    late var total = 0.0;
    List<CartModel2> data =
        draft.draftList.where((element) => element.id == id).toList();

    if (data.isNotEmpty) {
      data.first.data!.forEach((element) {
        total += double.tryParse(element.newPrice!)!;
      });
    }
    // cart
    //   ..forEach((element) {
    //     total += double.tryParse(element.newPrice!)!;
    //   });
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 66,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.elliptical(30, 10),
                        bottomRight: Radius.elliptical(30, 10),
                      ),
                      color: HexColor("#EFF2F5")),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: "Subtotal",
                              color: HexColor("#667085"),
                              fontWeight: FontWeight.w400,
                              size: 14,
                            ),
                            AppText(
                              text: "₦$total",
                              color: HexColor("#1D2939"),
                              fontWeight: FontWeight.w600,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: "VAT",
                              color: HexColor("#667085"),
                              fontWeight: FontWeight.w400,
                              size: 14,
                            ),
                            AppText(
                              text: "₦0",
                              color: HexColor("#1D2939"),
                              fontWeight: FontWeight.w600,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 280,
                  child: DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 4.0,
                    dashColor: HexColor("#98A2B3"),
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                    dashGapColor: Colors.transparent,
                    dashGapRadius: 0.0,
                  ),
                ),
                Container(
                  height: 66,
                  decoration: BoxDecoration(
                    color: HexColor("#EFF2F5"),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.elliptical(30, 10),
                      topLeft: Radius.elliptical(30, 10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: "Total",
                          color: HexColor("#1D2939"),
                          fontWeight: FontWeight.w500,
                          size: 16,
                        ),
                        AppText(
                          text: "₦$total",
                          color: HexColor("#1D2939"),
                          fontWeight: FontWeight.w600,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(
              onTap: () {
                if (customerName.isEmpty) {
                  showToast("Please add customer name",
                      backgroundColor: Colors.red[900],
                      context: context,
                      position: StyledToastPosition.top);
                  return;
                }
                if (data.isEmpty) return;
                PageRouting.pushToPage(
                    context,
                    CheckOutScreen(
                      amount: total,
                      customer: customerName,
                      id: id,
                      isDraft: true,
                    ));
              },
              child: AppText(
                text: "Confirm & Accept Payment",
                color: Colors.white,
                size: 14,
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}
