import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../generalwidgets/SearchBox.dart';
import '../../generalwidgets/gen_page.dart';
import '../../generalwidgets/text.dart';
import 'order_listing.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
   
    return GenPage(
      title: "Orders",
      showMenu: true,
      hasDash: false,
      hint: 'Search orders',
      showFloat: false,
      showFooter: true,
      body: const OrderListings(),
    );
  }
}
