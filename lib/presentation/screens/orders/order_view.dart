import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/screens/orders/delete_modal.dart';
import 'package:salesapp/presentation/screens/orders/order_description.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../../model/order_model.dart';
import '../../generalwidgets/text.dart';
import 'order_listing.dart';

class OrderView extends StatefulWidget {
  final OrdersData order;
  const OrderView({super.key, required this.order});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 127,
        width: 358,
        decoration: BoxDecoration(
            color: white,
            border: Border.all(color: HexColor("#DFE5F3")),
            borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          splashColor: blue.withOpacity(.4),
          hoverColor: blue.withOpacity(.4),
          highlightColor: blue.withOpacity(.4),
          focusColor: blue.withOpacity(.4),
          onLongPress: () async {
            deleteDialogu(
                context,
                "Are you sure you want to discard this order?",
                "Discard order",
                "assets/icon/clear_cart.svg",
                red, widget.order.id!);
          },
          onTap: () {
            PageRouting.pushToPage(
                context,
                OrderDescription(
                  order: widget.order,
                  name: widget.order.customerName,
                ));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: widget.order.orderNumber!,
                    size: 14,
                    fontWeight: FontWeight.w500,
                    color: HexColor("#1D2939"),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: HexColor("#0A38A7"),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: widget.order.customerName!,
                    size: 12,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#667085"),
                  ),
                  AppText(
                    text: Operations.convertDate(widget.order.createdAt!)
                        .toString(),
                    size: 12,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#475467"),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "Payment Status",
                    size: 12,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#667085"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: HexColor("#ECFDF3"),
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: AppText(
                        text: widget.order.status!,
                        size: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#027A48"),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
