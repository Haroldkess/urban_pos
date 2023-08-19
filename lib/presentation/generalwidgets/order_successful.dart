import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/button.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/home/home_screen.dart';
import 'package:salesapp/presentation/screens/orders/filter/by_date.dart';
import 'package:salesapp/services/controllers/cart_controller.dart';
import 'package:salesapp/services/controllers/operations.dart';
import 'package:salesapp/services/controllers/order_controller.dart';
import 'package:salesapp/services/controllers/product_controller.dart';

import '../../model/shop_settings_model.dart';
import '../../services/controllers/login_controller.dart';
import '../constant/colors.dart';
import '../functions/allNavigation.dart';
import 'invoice/api/pdf_api.dart';
import 'invoice/api/pdf_invoice_api.dart';
import 'invoice/model/customer.dart';
import 'invoice/model/invoice.dart';
import 'invoice/model/supplier.dart';

class OrderSuccessful extends StatelessWidget {
  final String cash;
  final String bank;
  final String pos;
  final double amount;
  final String name;
  final String satus;
  final String orderNum;
  const OrderSuccessful(
      {super.key,
      required this.bank,
      required this.cash,
      required this.pos,
      required this.amount,
      required this.satus,
      required this.orderNum,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        PageRouting.removeAllToPage(context, const HomeScreen());

        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset("assets/icon/done.svg")),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "Payment Successful",
                    color: HexColor("#1D2939"),
                    size: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: "Sale has been processed successfully",
                    color: HexColor("#667085"),
                    size: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 122,
                //  width: 350,
                decoration: BoxDecoration(
                    color: HexColor("#F4F6FA"),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Cash",
                            color: HexColor("#667085"),
                            fontWeight: FontWeight.w400,
                            size: 14,
                          ),
                          AppText(
                            text: "₦${convertToCurrency(cash.toString())}",
                            color: HexColor("#344054"),
                            fontWeight: FontWeight.w600,
                            size: 14,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Pos",
                            color: HexColor("#667085"),
                            fontWeight: FontWeight.w400,
                            size: 14,
                          ),
                          AppText(
                            text: "₦${convertToCurrency(pos.toString())}",
                            color: HexColor("#344054"),
                            fontWeight: FontWeight.w600,
                            size: 14,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Bank Transfer",
                            color: HexColor("#667085"),
                            fontWeight: FontWeight.w400,
                            size: 14,
                          ),
                          AppText(
                            text: "₦${convertToCurrency(bank.toString())}",
                            color: HexColor("#344054"),
                            fontWeight: FontWeight.w600,
                            size: 14,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Order Amount",
                            color: HexColor("#667085"),
                            fontWeight: FontWeight.w400,
                            size: 14,
                          ),
                          AppText(
                            text: "₦${convertToCurrency(amount.toString())}",
                            color: HexColor("#344054"),
                            fontWeight: FontWeight.w600,
                            size: 14,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "Change Due",
                            color: HexColor("#667085"),
                            fontWeight: FontWeight.w400,
                            size: 14,
                          ),
                          AppText(
                            text: (amount -
                                        double.tryParse(bank)! -
                                        double.tryParse(pos)! -
                                        double.tryParse(cash)!)
                                    .isNegative
                                ? "₦${convertToCurrency((amount - double.tryParse(bank)! - double.tryParse(pos)! - double.tryParse(cash)!).toString())}"
                                : "₦${convertToCurrency("0.0")}",
                            color: HexColor("#344054"),
                            fontWeight: FontWeight.w600,
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => Operations.openPdf(
                    context, name, satus, orderNum, amount, bank, pos, cash),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                      color: HexColor("#F4F6FA"),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icon/printer.svg"),
                      const SizedBox(
                        width: 5,
                      ),
                      AppText(
                        text: "Print Invoice",
                        color: HexColor("#667085"),
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              MyButton(
                width: 358,
                backColor: HexColor("#0A38A7"),
                onTap: () {
                  PageRouting.removeAllToPage(context, const HomeScreen());
                },
                child: AppText(
                  text: "Back to home",
                  color: HexColor("#FFFFFF"),
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
