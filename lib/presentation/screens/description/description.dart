import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/generalwidgets/button.dart';
import 'package:salesapp/presentation/generalwidgets/form_field.dart';
import 'package:salesapp/presentation/generalwidgets/qty_selector.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/cart/cart_screen.dart';
import 'package:salesapp/presentation/screens/description/header.dart';
import 'package:salesapp/presentation/screens/description/type_select.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/controllers/cart_controller.dart';

import '../../../model/product_model.dart';
import '../../../services/controllers/operations.dart';
import '../../uimodels/prod_model.dart';

Future<void> showDiscription(context, ProductDatum product,
    [bool? isDraft, String? id]) async {
  Operations.clearFields(
    context,
  );
  Operations.addAmountStart(context, 0);
  Operations.addType(
      context,
      product.shopProductWholesalePrices!.isEmpty
          ? "Retail"
          : product.shopProductWholesalePrices!.first.name ?? "");
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        UiProvider stream = context.watch<UiProvider>();
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: SimpleDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 5),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            title: DescriptionHeader(product: product),
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              TypeSelect(
                product: product,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: HexColor("#F2F4F7"),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppFormField(
                        fieldName: "Serial no(S)/IMEI(s)",
                        hint: "Add serial number",
                        color: HexColor("#DFE5F3"),
                        isCart: true,
                        action: "sn",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppFormField(
                        fieldName: "Add note",
                        hint: "Type special note",
                        color: HexColor("#DFE5F3"),
                        isCart: true,
                        action: "note",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    QuantitySelector(
                      fieldName: "Qty",
                      product: product,
                      pricing: product.shopProductWholesalePrices,
                      name: stream.type,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppFormField(
                      fieldName: "Amount",
                      hint: "NGN ${stream.descAmount.toString()}",
                      isCart: true,
                      action: "amount",
                      //initValue: stream.descAmount.toString(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(
                        onTap: () {
                          UiProvider qty =
                              Provider.of<UiProvider>(context, listen: false);
                          if (qty.qty < 1) {
                            showToast("Please add quanity",
                                context: context,
                                backgroundColor: Colors.red,
                                position: StyledToastPosition.center);
                            return;
                          } else {
                            if (isDraft == true) {
                              CartController.addToDraftCart(
                                  context, product, id!);
                            } else {
                              CartController.addToCart(context, product);
                            }
                          }
                        },
                        child: AppText(
                          text: "Add to order",
                          color: Colors.white,
                          size: 14,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      });
}
