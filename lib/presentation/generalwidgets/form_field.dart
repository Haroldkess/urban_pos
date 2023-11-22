import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../uiproviders/ui_provider.dart';

class AppFormField extends StatelessWidget {
  TextEditingController? controller;
  String? hint;
  String? prefixIcon;
  String? suffixIcon;
  String? fieldName;
  Color? color;
  double? width;
  double? fieldSize;
  bool? isCart;
  String? action;
  String? initValue;
  bool? isNumber;
  Function()? tap;
  bool? isEnabled;
  FocusNode? focus;
  bool? autoFocus;
  int? id;

  AppFormField(
      {Key? key,
      this.autoFocus,
      this.controller,
      this.hint,
      this.suffixIcon,
      this.prefixIcon,
      this.initValue,
      this.fieldName,
      this.fieldSize,
      this.color,
      this.isCart,
      this.action,
      this.focus,
      this.isNumber,
      this.width,
      this.tap,
      this.isEnabled,
      this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: fieldName ?? "",
          size: fieldSize ?? 12,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
                color: color ?? Colors.transparent,
                border: Border.all(color: HexColor("#DFE5F3")),
                borderRadius: const BorderRadius.all(Radius.circular(11)),
                shape: BoxShape.rectangle),
            height: 55,
            width: width ?? 350,
            child: TextFormField(
              controller: controller,
              onTap: tap,
              enabled: isEnabled ?? true,
              focusNode: focus,

              //   initialValue: initValue ,
              onChanged: (value) {
                UiProvider ui = Provider.of<UiProvider>(context, listen: false);
                if (isCart != true) {
                } else {
                  if (action == "note") {
                    Operations.addNoteCart(context, value);
                  } else if (action == "sn") {
                    Operations.addSnCart(context, value);
                  } else if (action == "amount") {
                    Operations.addAmountCart(context, value);
                    if (id != null) {
                      if (value.isNotEmpty) {
                        DescriprionController.instance.updatePrice(id, value);
                      } else {
                        DescriprionController.instance.updatePrice(id, "0");
                      }
                    }
                  }
                }
              },
              keyboardType: isNumber == true
                  ? const TextInputType.numberWithOptions()
                  : null,
              inputFormatters: isNumber == true
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("[-,' ',',']"))
                    ]
                  : null,
              autofocus: autoFocus ?? false,
              onSaved: (input) {},
              decoration: InputDecoration(
                hintText: "   $hint",
                hintStyle: GoogleFonts.workSans(
                    textStyle: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: HexColor("#98A2B3"),
                            decorationStyle: TextDecorationStyle.solid,
                            fontSize: 15))),
                contentPadding: prefixIcon == null
                    ? EdgeInsets.only(left: 17)
                    : const EdgeInsets.only(top: 17),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(prefixIcon!),
                      )
                    : null,
                suffixIcon: suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          suffixIcon!,
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
            )),
      ],
    );
  }
}

class AppFormField2 extends StatelessWidget {
  TextEditingController? controller;
  String? hint;
  String? prefixIcon;
  String? suffixIcon;
  String? fieldName;
  Color? color;
  double? width;
  double? fieldSize;
  bool? isCart;
  String? action;
  String? initValue;
  bool? isNumber;
  bool? isEnabled;
  Color? borderColor;
  Color? hintColor;
  Color? svgColor;
  AppFormField2(
      {Key? key,
      this.isEnabled,
      this.controller,
      this.hint,
      this.svgColor,
      this.suffixIcon,
      this.borderColor,
      this.hintColor,
      this.prefixIcon,
      this.initValue,
      this.fieldName,
      this.fieldSize,
      this.color,
      this.isCart,
      this.action,
      this.isNumber,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: fieldName ?? "",
          size: fieldSize ?? 12,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
                color: color ?? Colors.transparent,
                border: Border.all(color: borderColor ?? HexColor("#DFE5F3")),
                borderRadius: const BorderRadius.all(Radius.circular(11)),
                shape: BoxShape.rectangle),
            height: 55,
            width: width ?? 350,
            child: TextFormField(
              enabled: isEnabled ?? true,
              controller: controller,
              //   initialValue: initValue ,
              onChanged: (value) {},
              keyboardType: isNumber == true
                  ? const TextInputType.numberWithOptions()
                  : null,
              inputFormatters: isNumber == true
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.deny(RegExp("[-,' ',',']"))
                    ]
                  : null,
              onSaved: (input) {},
              decoration: InputDecoration(
                hintText: "   $hint",
                hintStyle: GoogleFonts.workSans(
                    textStyle: GoogleFonts.plusJakartaSans(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: hintColor ?? HexColor("#98A2B3"),
                            decorationStyle: TextDecorationStyle.solid,
                            fontSize: 15))),
                contentPadding: prefixIcon == null
                    ? EdgeInsets.only(
                        left: 17, top: suffixIcon != null ? 15 : 0)
                    : const EdgeInsets.only(top: 17),
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          prefixIcon!,
                          color: svgColor,
                        ),
                      )
                    : null,
                suffixIcon: suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SvgPicture.asset(
                          suffixIcon!,
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
            )),
      ],
    );
  }
}
