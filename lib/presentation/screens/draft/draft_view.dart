import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesapp/model/cart_model.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/screens/draft/delete_draft.dart';
import 'package:salesapp/presentation/screens/draft/draft_cart/draft_cart_screen.dart';
import 'package:salesapp/presentation/screens/orders/delete_modal.dart';
import 'package:salesapp/presentation/screens/orders/order_description.dart';
import 'package:salesapp/services/controllers/operations.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import '../../../model/order_model.dart';
import '../../generalwidgets/text.dart';

class DraftView extends StatefulWidget {
  final CartModel2 data;
  const DraftView({super.key, required this.data});

  @override
  State<DraftView> createState() => _DraftViewState();
}

class _DraftViewState extends State<DraftView> {
  bool show = false;
  final GlobalKey<ExpansionTileCardState> card = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        // height: 110,
        width: 358,
        decoration: BoxDecoration(
            color: HexColor("#F9FAFB"),
            border: Border.all(color: HexColor("#DFE5F3")),
            borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          splashColor: blue.withOpacity(.4),
          hoverColor: blue.withOpacity(.4),
          highlightColor: blue.withOpacity(.4),
          focusColor: blue.withOpacity(.4),
          onTap: () {
            // PageRouting.pushToPage(
            //     context,
            //     OrderDescription(
            //       order: widget.order,
            //       name: widget.order.customerName,
            //     ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ExpansionTileCard(
                  key: card,
                  elevation: 0,
                  baseColor: HexColor("#F9FAFB"),
                  expandedColor: HexColor("#F9FAFB"),
                  contentPadding: EdgeInsets.zero,
                  title: AppText(
                    text: widget.data.customerName!,
                    size: 14,
                    fontWeight: FontWeight.w500,
                    color: HexColor("#101828"),
                  ),
                  children: [
                    Container(
                      height: 39,
                      color: white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Date",
                                size: 12,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#667085"),
                              ),
                              AppText(
                                text: Operations.convertDate(
                                    widget.data.createdAt!),
                                size: 12,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#667085"),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 39,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Items Bought",
                                size: 12,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#667085"),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                constraints: BoxConstraints(maxWidth: 150),
                                child: AppText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: widget.data.data!.length > 1
                                      ? "${widget.data.data!.first.product!.name}, ${widget.data.data!.last.product!.name}"
                                      : "${widget.data.data!.first.product!.name}",
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#667085"),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Container(
                      height: 39,
                      color: white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Actions",
                                size: 12,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#667085"),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        PageRouting.pushToPage(
                                            context,  DraftCartScreen(data: widget.data,));
                                      },
                                      child: SvgPicture.asset(
                                          "assets/icon/edit.svg")),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        deleteDraftDialogu(
                                            context,
                                            "Are you sure you want to delete this draft?",
                                            "Delete Draft",
                                            "assets/icon/trash.svg",
                                            red,
                                            widget.data.id!);
                                      },
                                      child: SvgPicture.asset(
                                          "assets/icon/trash.svg")),
                                ],
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
             
             
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Timestamp",
                        size: 12,
                        fontWeight: FontWeight.w600,
                        color: HexColor("#667085"),
                      ),
                      AppText(
                        text: Operations.convertDate(widget.data.createdAt!),
                        size: 12,
                        fontWeight: FontWeight.w600,
                        color: HexColor("#667085"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
