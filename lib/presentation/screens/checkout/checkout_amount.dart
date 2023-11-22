import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/generalwidgets/button.dart';
import 'package:salesapp/presentation/generalwidgets/form_field.dart';
import 'package:salesapp/presentation/generalwidgets/order_successful.dart';
import 'package:salesapp/services/controllers/order_controller.dart';
import 'dart:math' as rand;
import '../../../services/controllers/cart_controller.dart';
import '../../../services/controllers/login_controller.dart';
import '../../../services/controllers/product_controller.dart';
import '../../constant/colors.dart';
import '../../generalwidgets/text.dart';
import '../../uiproviders/ui_provider.dart';

class CheckOutAmount extends StatefulWidget {
  final double amount;
  final String customerName;
  bool? isDraft;
  String? id;
  CheckOutAmount(
      {super.key,
      required this.amount,
      required this.customerName,
      this.isDraft,
      this.id});

  @override
  State<CheckOutAmount> createState() => _CheckOutAmountState();
}

class _CheckOutAmountState extends State<CheckOutAmount> {
  TextEditingController cash = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController pos = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          AppFormField(
            hint: "0.0",
            fieldName: "Cash",
            color: Colors.white,
            controller: cash,
            fieldSize: 14,
            isNumber: true,
          ),
          const SizedBox(
            height: 16,
          ),
          AppFormField(
            hint: "0.0",
            fieldName: "Bank Transfer",
            color: Colors.white,
            controller: bank,
            fieldSize: 14,
            isNumber: true,
          ),
          const SizedBox(
            height: 16,
          ),
          AppFormField(
            hint: "0.0",
            fieldName: "POS",
            color: Colors.white,
            isNumber: true,
            fieldSize: 14,
            controller: pos,
          ),
          const SizedBox(
            height: 30,
          ),
          MyButton(
            width: 358,
            backColor: HexColor("#0A38A7"),
            onTap: () {
              UiProvider ui = Provider.of<UiProvider>(context, listen: false);
              ProductProvider product = Provider.of(context, listen: false);
              late double customerPaid;
              // if (cash.text.isEmpty && bank.text.isEmpty && pos.text.isEmpty) {
              //   showToast("Add amount",
              //       context: context,
              //       backgroundColor: Colors.red[900],
              //       position: StyledToastPosition.top);
              //   return;
              // }
              if (ui.paymentMethod.isEmpty) {
                showToast("Select payment method",
                    context: context,
                    backgroundColor: Colors.red[900],
                    position: StyledToastPosition.top);

                return;
              }
              customerPaid = 0.0;
              if (cash.text.isNotEmpty) {
                customerPaid +=
                    double.tryParse(cash.text.isEmpty ? "0.0" : cash.text)!;
              }
              if (bank.text.isNotEmpty) {
                customerPaid +=
                    double.tryParse(bank.text.isEmpty ? "0.0" : bank.text)!;
              }
              if (pos.text.isNotEmpty) {
                customerPaid +=
                    double.tryParse(pos.text.isEmpty ? "0.0" : pos.text)!;
              }
              final amountPaid =
                  double.tryParse(cash.text.isEmpty ? "0.0" : cash.text)! +
                      double.tryParse(bank.text.isEmpty ? "0.0" : bank.text)! +
                      double.tryParse(pos.text.isEmpty ? "0.0" : pos.text)!;

              try {
                String r =
                    rand.Random().nextInt(999999).toString().padLeft(5, '0');
                final orderNum =
                    "000${product.shopProduct.first.shopId}${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}$r";
                if (widget.isDraft == true) {
                  OrderController.addFromDraftToOrders(
                          context,
                          amountPaid < widget.amount
                              ? "incomplete payment"
                              : "paid",
                          widget.amount,
                          customerPaid,
                          widget.customerName,
                          widget.id!,
                          orderNum)
                      .whenComplete(() => PageRouting.pushToPage(
                          context,
                          OrderSuccessful(
                            amount: widget.amount,
                            pos: pos.text.isEmpty ? "0.0" : pos.text,
                            bank: bank.text.isEmpty ? "0.0" : bank.text,
                            cash: cash.text.isEmpty ? "0.0" : cash.text,
                            name: widget.customerName,
                            satus: amountPaid < widget.amount
                                ? "incomplete payment"
                                : "paid",
                            orderNum: orderNum,
                          )));
                } else {
                  OrderController.addToOrders(
                          context,
                          amountPaid < widget.amount
                              ? "incomplete payment"
                              : "paid",
                          widget.amount,
                          customerPaid,
                          widget.customerName,
                          orderNum)
                      .whenComplete(() => PageRouting.pushToPage(
                          context,
                          OrderSuccessful(
                            amount: widget.amount,
                            pos: pos.text.isEmpty ? "0.0" : pos.text,
                            bank: bank.text.isEmpty ? "0.0" : bank.text,
                            cash: cash.text.isEmpty ? "0.0" : cash.text,
                            name: widget.customerName,
                            satus: amountPaid < widget.amount
                                ? "incomplete payment"
                                : "paid",
                            orderNum: orderNum,
                          )));
                }
              } catch (e) {
                showToast("$e",
                    context: context,
                    backgroundColor: Colors.red[900],
                    position: StyledToastPosition.top);
              }
            },
            child: AppText(
              text: "Pay Now",
              color: HexColor("#FFFFFF"),
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class AmountDue extends StatelessWidget {
  final double? myAmount;
  const AmountDue({super.key, this.myAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 52,
        //  width: 350,
        decoration: BoxDecoration(
            color: HexColor("#FAF7F0"),
            border: Border.all(color: HexColor("#E8D5B5")),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "Amount Due",
                color: HexColor("#746B5B"),
                fontWeight: FontWeight.w500,
                size: 16,
              ),
              AppText(
                text: "₦${convertToCurrency(myAmount.toString())}",
                color: HexColor("#344054"),
                fontWeight: FontWeight.w600,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
