import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/model/cart_model.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/draft/draft_view.dart';
import 'package:salesapp/presentation/screens/orders/order_view.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/controllers/cart_controller.dart';
import 'package:salesapp/services/controllers/order_controller.dart';

import '../../../model/order_model.dart';
import '../../../services/controllers/operations.dart';

class DraftListings extends StatelessWidget {
  const DraftListings({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider draft = context.watch<CartProvider>();
    UiProvider stream = context.watch<UiProvider>();
    return draft.draftList.isEmpty
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
              List<CartModel2> draftData = draft.draftList
                  .where((element) => element.customerName!
                      .toLowerCase()
                      .contains(stream.draftSearch.toLowerCase()))
                  .toList();
              return ListView.builder(
                  itemCount: draftData.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    CartModel2 order = draftData[index];
                    return DraftView(
                      data: order,
                    );
                  });
            });
  }
}
