import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/button.dart';
import 'package:salesapp/presentation/generalwidgets/form_field.dart';
import 'package:salesapp/presentation/generalwidgets/qty_selector.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/screens/description/header.dart';
import 'package:salesapp/presentation/screens/description/type_select.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/controllers/cart_controller.dart';

import '../../../model/product_model.dart';
import '../../../services/controllers/new_operation.dart';
import '../../../services/controllers/operations.dart';

Future<void> showDiscription(context, ProductDatum product, bool isHome,
    [bool? isDraft, String? id]) async {
  TextEditingController subAmount = TextEditingController();
  Operations.clearFields(
    context,
  );
  Operations.addAmountStart(context, 0);
  Operations.addType(
      context,
      product.shopProductWholesalePrices!.isEmpty
          ? "Retail"
          : product.shopProductWholesalePrices!.first.name ?? "");
  WholeSaleOperation.removeAndAddWholeSale(
      context, product.shopProductWholesalePrices, product);
  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        UiProvider stream = context.watch<UiProvider>();
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: GetBuilder<DescriprionController>(
            init: DescriprionController(),
            builder: (wholesale) {
              //  if (wholesale.sales.isNotEmpty) {
              //   subAmount = TextEditingController(
              //       text: wholesale.sales
              //           .where((p0) => p0.selected!.value == true)
              //           .first
              //           .amount!);
              // }

              double priced = 0.0;
              if (wholesale.sales.isNotEmpty) {
                for (var element in wholesale.sales) {
                  priced += double.tryParse(element.amount.toString())!;
                }
              }

              return SimpleDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 5),
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                title: DescriptionHeader(
                  product: product,
                  price: wholesale.sales
                          .where((p0) => p0.selected!.value == true)
                          .toList()
                          .isNotEmpty
                      ? wholesale.sales
                          .where((p0) => p0.selected!.value == true)
                          .first
                          .wholeSale!
                          .price
                      : null,
                ),
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  TypeSelect(
                    product: product,
                    wholesale: wholesale,
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
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            altPrice: wholesale.sales
                                    .where((p0) => p0.selected!.value == true)
                                    .toList()
                                    .isNotEmpty
                                ? wholesale.sales
                                    .where((p0) => p0.selected!.value == true)
                                    .toList()
                                    .first
                                    .wholeSale
                                : null,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ObxValue((controller) {
                            return AppFormField(
                              fieldName: "Sub Amount - Pair",
                              hint:
                                  "NGN ${wholesale.sales.where((p0) => p0.selected!.value == true).toList().isNotEmpty ? wholesale.sales.where((p0) => p0.selected!.value == true).first.amount : "0.0"}",
                              //      hint: "NGN ${stream.descAmount.toString()}",
                              isCart: true,
                              action: "amount",
                              controller: controller
                                  .where((p0) => p0.selected!.value == true)
                                  .first
                                  .subAmount
                                  .value,
                              id: controller
                                  .where((p0) => p0.selected!.value == true)
                                  .first
                                  .wholeSale!
                                  .id,
                              isNumber: true,
                              //initValue: stream.descAmount.toString(),
                            );
                          }, DescriprionController.instance.sales),
                          const SizedBox(
                            height: 10,
                          ),
                          AppFormField(
                            fieldName: "Total Amount",
                            hint:
                                "NGN ${wholesale.sales.where((p0) => p0.selected!.value == true).toList().isNotEmpty ? priced : "0.0"}",
                            //      hint: "NGN ${stream.descAmount.toString()}",
                            isCart: true,
                            action: "amount",
                            isEnabled: false,
                            //initValue: stream.descAmount.toString(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyButton(
                              onTap: () async {
                                int allQty = 0;

                                for (var element in wholesale.sales) {
                                  allQty += element.qty!.value;
                                }

                                // UiProvider qty = Provider.of<UiProvider>(
                                //     context,
                                //     listen: false);
                                if (allQty < 1) {
                                  showToast("Please add quanity",
                                      context: context,
                                      backgroundColor: Colors.red,
                                      position: StyledToastPosition.center);
                                  return;
                                } else {
                                  if (isDraft == true) {
                                    CartController.addToDraftCart(
                                        context,
                                        product,
                                        id!,
                                        wholesale,
                                        allQty,
                                        priced,
                                        int.tryParse(wholesale
                                            .sales.first.qty!.value
                                            .toString())!);
                                  } else {
                                    CartController.addToCart(
                                        context,
                                        isHome,
                                        product,
                                        wholesale,
                                        allQty,
                                        priced,
                                        int.tryParse(wholesale
                                            .sales.first.qty!.value
                                            .toString())!);
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            },
          ),
        );
      });
}
