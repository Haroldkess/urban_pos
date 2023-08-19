// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/generalwidgets/banner.dart';
import 'package:salesapp/presentation/generalwidgets/button.dart';
import 'package:salesapp/presentation/generalwidgets/form_field.dart';
import 'package:salesapp/presentation/generalwidgets/qty_selector.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/cart/cart_screen.dart';
import 'package:salesapp/presentation/screens/description/header.dart';
import 'package:salesapp/presentation/screens/description/type_select.dart';

import '../../../../services/controllers/cart_controller.dart';
import '../../../../services/controllers/operations.dart';
import '../../draft/draft_screen.dart';

Future<void> showCartDialogu(
    context, String desc, String title, String icon, Color color, bool isClear,
    [String? customer]) async {
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SimpleDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 5),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            title: Row(
              children: [SvgPicture.asset(icon)],
            ),
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: title,
                          color: HexColor("#101828"),
                          size: 18,
                          align: TextAlign.left,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: AppText(
                            text: desc,
                            color: HexColor("#667085"),
                            size: 14,
                            align: TextAlign.left,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyButton(
                            width: 140,
                            backColor: Colors.white,
                            onTap: () async {
                              if (isClear) {
                                if (customer == null || customer.isEmpty) {
                                  showBanner("Add Customer name", red, context);
                                  PageRouting.popToPage(context);
                                } else {
                                  await CartController.saveToDraft(
                                      context, customer);
                                        PageRouting.popToPage(context);
                                  showCartDialogu(
                                      context,
                                      "Order suspended kindly visit the draft page",
                                      "Order Suspended",
                                      "assets/icon/order sus.svg",
                                      Colors.blue.shade900,
                                      false,
                                      customer);
                                }
                              } else {
                                PageRouting.popToPage(context);
                              }
                            },
                            child: AppText(
                              text: isClear ? "Suspend Order" : "Continue",
                              color: HexColor("#344054"),
                              size: 14,
                              fontWeight: FontWeight.w500,
                            )),
                        MyButton(
                            width: 140,
                            backColor: color,
                            onTap: () async {
                              if (isClear) {
                                await CartController.deleteAll(context);
                                PageRouting.popToPage(context);
                              } else {
                                 PageRouting.popToPage(context);
                                Operations.cleaarSearch(context);
                                PageRouting.removePreviousToPage(
                                    context, const DraftScreen());
                              }
                            },
                            child: AppText(
                              text: isClear ? "Clear Cart" : "View Drafts",
                              color: Colors.white,
                              size: 14,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
}
