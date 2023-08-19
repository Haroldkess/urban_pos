import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';

import '../../../model/order_model.dart';
import '../../generalwidgets/text.dart';
import 'order_details.dart';
import 'order_payment.dart';

class OrderDescription extends StatelessWidget {
  final String? name;
  final OrdersData? order;
  const OrderDescription({super.key, required this.order, this.name});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    UiProvider stream = context.watch<UiProvider>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.15,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      child: SvgPicture.asset(
                        "assets/icon/arrow-left.svg",
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AppText(
                      text: "$name Order",
                      color: HexColor("#475467"),
                      fontWeight: FontWeight.w500,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: const Size(358, 40),
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: HexColor("#F2F4F7"),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              UiProvider action = Provider.of<UiProvider>(
                                  context,
                                  listen: false);
                              action.changeTab(0);
                            },
                            child: stream.orderTab == 0
                                ? selected("Order Details")
                                : unSelected("Order Details")),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                            onTap: () {
                              UiProvider action = Provider.of<UiProvider>(
                                  context,
                                  listen: false);
                              action.changeTab(1);
                            },
                            child: stream.orderTab == 1
                                ? selected("Payment")
                                : unSelected("Payment"))
                      ],
                    ),
                  ),
                ),
              )),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: stream.orderTab == 0
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: OrderDetails(
                    order: order!,
                  ),
                )
              : OrderPayment(order: order!,),
        ));
  }

  Container selected(String name) {
    return Container(
        height: 30,
        width: 113,
        decoration: BoxDecoration(
            border: Border.all(color: HexColor("#849BD3")),
            borderRadius: BorderRadius.circular(8),
            color: HexColor("#FFFFFF")),
        child: Center(
          child: AppText(
            text: name,
            color: HexColor("#667085"),
            size: 14,
            fontWeight: FontWeight.w500,
          ),
        ));
  }

  Container unSelected(String name) {
    return Container(
        height: 30,
        width: 113,
        decoration: BoxDecoration(
            border: Border.all(color: HexColor("#F4F6FA")),
            borderRadius: BorderRadius.circular(8),
            color: HexColor("#F4F6FA")),
        child: Center(
          child: AppText(
            text: name,
            color: HexColor("#667085"),
            size: 14,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}

class OrderDetailModel {
  String orderNum;
  String soldBy;
  String status;
  String channel;
  String name;
  String qty;
  String subTotal;
  String vat;
  String fee;
  String total;

  OrderDetailModel(
      {required this.orderNum,
      required this.soldBy,
      required this.status,
      required this.channel,
      required this.name,
      required this.qty,
      required this.subTotal,
      required this.vat,
      required this.fee,
      required this.total});
}

OrderDetailModel details = OrderDetailModel(
    orderNum: "3063908730639087",
    soldBy: "Lionel Messi",
    status: "Paid",
    channel: "Desktop",
    name: "Soundcore Anker Life P3",
    qty: "qty",
    subTotal: "12",
    vat: "₦0",
    fee: "₦0",
    total: "₦60,000");

class OrderPaymentModel {
  String icon;
  String title;
  String date;
  String amount;
  OrderPaymentModel(
      {required this.icon,
      required this.title,
      required this.date,
      required this.amount});
}

List<OrderPaymentModel> payModel = [
  OrderPaymentModel(
      icon: "assets/icons/cash.svg",
      title: "Cash Payment",
      date: "Today  | 03:55am",
      amount: "₦3,000.00"),
  OrderPaymentModel(
      icon: "assets/icons/cash.svg",
      title: "Cash Payment",
      date: "Today  | 03:55am",
      amount: "₦3,000.00"),
  OrderPaymentModel(
      icon: "assets/icons/cash.svg",
      title: "Cash Payment",
      date: "Today  | 03:55am",
      amount: "₦3,000.00"),
  OrderPaymentModel(
      icon: "assets/icon/bank.svg",
      title: "Bank Tranfer",
      date: "Today  | 03:55am",
      amount: "₦3,000.00"),
  OrderPaymentModel(
      icon: "assets/icon/card-pos.svg",
      title: "POS",
      date: "Today  | 03:55am",
      amount: "₦3,000.00"),
  OrderPaymentModel(
      icon: "assets/icon/card-pos.svg",
      title: "POS",
      date: "Today  | 03:55am",
      amount: "₦3,000.00"),
];
