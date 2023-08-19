// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/generalwidgets/SearchBox.dart';
import 'package:salesapp/presentation/generalwidgets/drawer.dart';
import 'package:salesapp/presentation/generalwidgets/loader.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/home/category_view/category_slide.dart';
import 'package:salesapp/presentation/screens/home/product_views/grid_views.dart';
import 'package:salesapp/presentation/screens/home/product_views/vertical_views.dart';
import 'package:salesapp/presentation/screens/orders/filter/by_date.dart';
import 'package:salesapp/presentation/screens/orders/filter/status.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/controllers/cart_controller.dart';
import 'package:salesapp/services/controllers/operations.dart';
import 'package:salesapp/services/controllers/order_controller.dart';
import 'package:salesapp/services/controllers/product_controller.dart';

import '../../services/middleware/server_thread.dart';
import '../functions/allNavigation.dart';
import '../screens/cart/cart_screen.dart';
import 'banner.dart';

class GenPage extends StatefulWidget {
  final String title;
  final bool hasDash;
  final String? searchTrail;
  final String hint;
  Widget? body;
  final bool showFloat;
  final bool showMenu;
  final bool showFooter;
  GenPage(
      {super.key,
      required this.title,
      required this.hasDash,
      this.searchTrail,
      required this.hint,
      required this.showFloat,
      required this.showMenu,
      required this.showFooter,
      this.body});

  @override
  State<GenPage> createState() => _GenPageState();
}

class _GenPageState extends State<GenPage> {
  final GlobalKey<ScaffoldState> key = GlobalKey();
  List<String> menu = ["Payment Status", "Today"];
  @override
  void initState() {
    super.initState();
    // initS
    // yncWorker();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    UiProvider stream = context.watch<UiProvider>();
    CartProvider cart = context.watch<CartProvider>();
    OrderProvider orders = context.watch<OrderProvider>();
    return Scaffold(
      key: key,
      persistentFooterButtons: widget.showFooter
          ? [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: HexColor("#D0D5DD"))),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back),
                    )),
                AppText(
                  text: "Page 1 of 1",
                  size: 14,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#344054"),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: HexColor("#D0D5DD"))),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_forward),
                    ))
              ])
            ]
          : null,
      appBar: AppBar(
        toolbarHeight: height * 0.15,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: widget.title == "Home" || widget.title == "Draft"
                        ? 35
                        : 40,
                    width: widget.title == "Home" || widget.title == "Draft"
                        ? 35
                        : 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: HexColor("#DFE5F3"))),
                    child: const Center(
                      child: Icon(
                        Icons.menu,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppText(
                    text: widget.title,
                    color: HexColor("#475467"),
                    fontWeight: FontWeight.w500,
                    size: 20,
                  ),
                ],
              ),
              Row(
                children: [
                  widget.title == "Orders"
                      ? InkWell(
                          onTap: () async {
                            showToast("Syncing orders",
                                context: context,
                                backgroundColor: white,
                                textStyle: TextStyle(color: blue),
                                duration: Duration(seconds: 5),
                                position: StyledToastPosition.top);
                            await OrderController.syncOrder(context);
                          },
                          child: stream.loadOrder
                              ? Loader(
                                  color: blue,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HexColor("#F2F4F7")),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      "assets/icon/sync.svg",
                                      color: HexColor("#5C7AC4"),
                                    ),
                                  ),
                                ),
                        )
                      : InkWell(
                          onTap: () async {
                            if (orders.orders.isNotEmpty) {
                              inAppSnackBar(
                                  context,
                                  "Orders not synced since last sale. sync orders before product sync",
                                  true, () async {
                                await OrderController.syncOrder(context);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });
                              return;
                            }
                            showToast("Syncing products",
                                context: context,
                                backgroundColor: white,
                                textStyle: TextStyle(color: blue),
                                duration: Duration(seconds: 5),
                                position: StyledToastPosition.top);
                            await ProductController.syncProd(context);

                            showToast("Products synced",
                                context: context,
                                backgroundColor: blue,
                                // textStyle: TextStyle(color: blue),
                                duration: Duration(seconds: 5),
                                position: StyledToastPosition.top);
                          },
                          child: stream.loadProd
                              ? Loader(
                                  color: blue,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HexColor("#F2F4F7")),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      "assets/icon/sync.svg",
                                      color: HexColor("#5C7AC4"),
                                    ),
                                  ),
                                ),
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  widget.hasDash
                      ? InkWell(
                          onTap: () => Operations.toggleViews(context),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: HexColor("#F2F4F7")),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(stream.onGrid
                                  ? "assets/icon/dash2.svg"
                                  : "assets/icon/dashboard.svg"),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: Size(358, widget.showMenu ? 80 : 48),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 10, right: 10, bottom: widget.showMenu ? 0 : 20),
                  child: SearchBox(
                    hint: widget.hint,
                    suffixIcon: widget.searchTrail ?? "",
                    prefixIcon: "assets/icon/search.svg",
                    screen: widget.title,
                  ),
                ),
                widget.showMenu
                    ? Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, top: 10, left: 8),
                        child: Row(
                          children: [...menu.map((e) => MenuView(name: e))],
                        ),
                      )
                    : SizedBox.shrink()
              ],
            )),
      ),
      drawer: DrawerSide(scafKey: key),
      body: widget.body ?? Container(),
      floatingActionButton: widget.showFloat
          ? Container(
              child: FittedBox(
                child: Stack(
                  alignment: const Alignment(1.4, -1.5),
                  children: [
                    FloatingActionButton(
                      // Your actual Fab
                      onPressed: () =>
                          PageRouting.pushToPage(context, const CartScreen()),
                      backgroundColor: HexColor("#0A38A7"),
                      child: SvgPicture.asset("assets/icon/cart.svg"),
                    ),
                    Container(
                      // This is your Badge
                      padding: const EdgeInsets.all(3),
                      constraints:
                          const BoxConstraints(minHeight: 25, minWidth: 25),
                      decoration: BoxDecoration(
                        // This controls the shadow
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 5,
                              color: Colors.black.withAlpha(50))
                        ],
                        borderRadius: BorderRadius.circular(16),
                        color: HexColor(
                            "#7AB5B7"), // This would be color of the Badge
                      ),
                      // This is your Badge
                      child: Center(
                        // Here you can put whatever content you want inside your Badge
                        child: Text(cart.cartProducts.length.toString(),
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}

class MenuView extends StatelessWidget {
  final String name;
  const MenuView({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    UiProvider stream = context.watch<UiProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          if (name == "Payment Status") {
            statusOrStaffFilter(context, true);
          } else if (name == "Sold By") {
            statusOrStaffFilter(context, false);
          } else {
            dateFilter(context);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: null,
              border: Border.all(color: HexColor("#E0E6F4")),
              borderRadius: BorderRadius.circular(100)),
          child: Row(
            children: [
              AppText(
                text: name == "Payment Status"
                    ? stream.orderFilter.isEmpty
                        ? "Payment Status"
                        : stream.orderFilter
                    : stream.dateType.isEmpty
                        ? "This Year"
                        : stream.dateType,
                color: HexColor("#344054"),
                size: 12,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                "assets/icon/down.svg",
                height: 7,
              )
            ],
          ),
        ),
      ),
    );
  }
}
