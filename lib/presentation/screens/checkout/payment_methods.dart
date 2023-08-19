import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';

class PayMentMethods extends StatelessWidget {
  const PayMentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    UiProvider stream = context.watch<UiProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: AppText(
            text: "Select payment method",
            color: HexColor("#101828"),
            size: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ...payments.map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: RadioListTile(
                  enableFeedback: true,
                  selectedTileColor: Colors.white,
                  controlAffinity: ListTileControlAffinity.trailing,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: HexColor("#DFE5F3")),
                      borderRadius: BorderRadius.circular(8)),
                  title: Row(
                    children: [
                      Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: HexColor(e.color!),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(e.icon!),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      AppText(
                        text: e.title!,
                        color: HexColor("#475467"),
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  value: stream.paymentMethod,
                  groupValue: e.title,
                  onChanged: (val) {
                    UiProvider ui =
                        Provider.of<UiProvider>(context, listen: false);
                    ui.addPayment(e.title!);
                  }),
            ))
      ],
    );
  }
}

class Methods {
  String? title;
  String? icon;
  String? color;
  Methods({this.title, this.icon, this.color});
}

List<Methods> payments = [
  Methods(
      title: "Offline Payment", icon: "assets/icon/cash.svg", color: "#EAEFF7"),
  Methods(
      title: "Instant Payment", icon: "assets/icon/bank.svg", color: "#FAF7F0"),
  Methods(
      title: "Customer Credit",
      icon: "assets/icon/card-pos.svg",
      color: "#F5F3FF"),
];
