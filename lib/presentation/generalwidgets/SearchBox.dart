import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../services/controllers/order_controller.dart';
import '../../services/controllers/product_controller.dart';

class SearchBox extends StatelessWidget {
  TextEditingController? controller;
  String? hint;
  String? prefixIcon;
  String screen;

  String? suffixIcon;

  SearchBox(
      {Key? key,
      this.controller,
      this.hint,
      this.suffixIcon,
      this.prefixIcon,
      required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider action =
        Provider.of<ProductProvider>(context, listen: false);
    OrderProvider order = Provider.of<OrderProvider>(context, listen: false);
       UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    return Container(
        decoration: BoxDecoration(
            color: HexColor("#F2F4F7"),
            border: Border.all(color: HexColor("#DFE5F3")),
            borderRadius: const BorderRadius.all(Radius.circular(11)),
            shape: BoxShape.rectangle),
        height: 55,
        width: 350,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            if (screen == "Orders") {
              order.searchOrder(value);
            } else if (screen == "Home") {
              action.searchProd(value, false);
            }else if (screen == "Draft") {
              ui.searchDraft(value);
            }
          },
          onSaved: (input) {},
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.workSans(
                textStyle: GoogleFonts.plusJakartaSans(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: HexColor("#98A2B3"),
                        decorationStyle: TextDecorationStyle.solid,
                        fontSize: 15))),
            contentPadding: const EdgeInsets.only(top: 17),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(prefixIcon!),
                  )
                : null,
            suffixIcon: suffixIcon != null || suffixIcon!.isNotEmpty
                ? InkWell(
                  onTap: ()=> Operations.barcodeScan(context) ,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        suffixIcon!,
                      ),
                    ),
                )
                : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(2.0),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
          ),
        ));
  }
}
