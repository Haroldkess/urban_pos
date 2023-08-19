import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/form_field.dart';
import 'package:salesapp/presentation/screens/cart/cart_dialogue/suspended.dart';
import 'package:salesapp/presentation/screens/cart/cart_price.dart';
import 'package:salesapp/presentation/screens/cart/cart_products.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';

import '../../../../model/cart_model.dart';
import '../../../generalwidgets/text.dart';
import 'draft_cart_price.dart';
import 'draft_cart_product.dart';

class DraftCartScreen extends StatefulWidget {
  CartModel2 data;
  DraftCartScreen({super.key, required this.data});

  @override
  State<DraftCartScreen> createState() => _DraftCartScreenState();
}

class _DraftCartScreenState extends State<DraftCartScreen> {
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  String _contact = "";
  TextEditingController customer = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      customer = TextEditingController(text: widget.data.customerName ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    UiProvider stream = context.watch<UiProvider>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.15,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: SvgPicture.asset(
                      "assets/icon/arrow-left.svg",
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  AppText(
                    text: "Draft Cart",
                    color: HexColor("#475467"),
                    fontWeight: FontWeight.w500,
                    size: 20,
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     InkWell(
              //       onTap: () {},
              //       child: Container(
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle, color: HexColor("#F2F4F7")),
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: SvgPicture.asset(
              //             "assets/icon/doc_upload.svg",
              //             color: HexColor("#5C7AC4"),
              //           ),
              //         ),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     InkWell(
              //       onTap: () => showCartDialogu(
              //           context,
              //           "Are you sure you want to discard this order? You could suspend the order instead.",
              //           "Clear Cart",
              //           "assets/icon/clear_cart.svg",
              //           Colors.red,
              //           true,
              //           customer.text.isEmpty ? "" : customer.text),
              //       child: Container(
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle, color: HexColor("#F2F4F7")),
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: SvgPicture.asset("assets/icon/trash.svg"),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size(358, 48),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppFormField(
                    width: 270,
                    hint: "Enter customer name",
                    action: "customer",
                    controller: customer,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      Contact? contact = await _contactPicker.selectContact();

                      setState(() {
                        customer =
                            TextEditingController(text: contact!.fullName!);
                      });

                      _contact = contact!.fullName!;
                    },
                    child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            border: Border.all(color: HexColor("#F4F6FA")),
                            borderRadius: BorderRadius.circular(8),
                            color: HexColor("#F4F6FA")),
                        child: const Icon(Icons.add)),
                  )
                ],
              ),
            )),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DraftCartProducts(
              id: widget.data.id!,
            ),
          )),
          Container(
            height: 240,
            color: Colors.white,
            child: DraftCartPrice(
              customerName: customer.text,
              id: widget.data.id!,
            ),
          )
        ],
      ),
    );
  }
}
