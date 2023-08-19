import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/orders/order_view.dart';
import 'package:salesapp/services/controllers/order_controller.dart';

import '../../../model/order_model.dart';
import '../../../services/controllers/operations.dart';
import '../../uiproviders/ui_provider.dart';

class OrderListings extends StatelessWidget {
  const OrderListings({super.key});

  @override
  Widget build(BuildContext context) {
    OrderProvider orders = context.watch<OrderProvider>();
    UiProvider stream = context.watch<UiProvider>();
    return orders.orders.isEmpty
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
        : StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              List<OrdersData> orderLister = orders.orders
                  .where((element) => element.status!
                      .toLowerCase()
                      .contains(stream.orderFilter == "Partial"
                          ? "incomplete payment"
                          : stream.orderFilter == "All"
                              ? ""
                              : stream.orderFilter.toLowerCase()))
                  .toList()
                  .where((element) =>
                      element.orderNumber!.contains(orders.orderSearch))
                  .toList()
                  .where((element) {
                return stream.dateType == "Custom"
                    ? element.createdAt!
                            .isAfter(stream.startDate ?? DateTime(2005)) &&
                        element.createdAt!
                            .isBefore(stream.endDate ?? DateTime.now())
                    : element.createdAt!.isAfter(stream.dateFilter!);
              }).toList();
              return ListView.builder(
                  itemCount: orderLister.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    OrdersData order = orderLister[index];
                    return OrderView(
                      order: order,
                    );
                  });
            });
  }
}

class OrderModel {
  String id;
  String name;
  String status;
  String date;

  OrderModel(
      {required this.date,
      required this.id,
      required this.name,
      required this.status});
}

List<OrderModel> ordersListing = [
  OrderModel(
      date: "Nov 24, 2023 - 19:02",
      id: "#0001D23012915YRMIOYN",
      name: "Mark Ronson",
      status: "Paid"),
  OrderModel(
      date: "Nov 24, 2023 - 19:02",
      id: "#0001D23012915YRMIOYN",
      name: "Mark Ronson",
      status: "Paid"),
  OrderModel(
      date: "Nov 24, 2023 - 19:02",
      id: "#0001D23012915YRMIOYN",
      name: "Mark Ronson",
      status: "Paid"),
  OrderModel(
      date: "Nov 24, 2023 - 19:02",
      id: "#0001D23012915YRMIOYN",
      name: "Mark Ronson",
      status: "Paid"),
  OrderModel(
      date: "Nov 24, 2023 - 19:02",
      id: "#0001D23012915YRMIOYN",
      name: "Mark Ronson",
      status: "Paid"),
  OrderModel(
      date: "Nov 24, 2023 - 19:02",
      id: "#0001D23012915YRMIOYN",
      name: "Mark Ronson",
      status: "Paid"),
];
