import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';

List<String> status = [
  "All",
  "Paid",
  "Pending",
  "Refund",
  "Partial"
];
List<String> staff = [
  "Joy Irabor Ngozi",
  "David Fayemi",
  "Naza Chibuike",
  "Abubakr Fawaz"
];

statusOrStaffFilter(BuildContext context, bool isStatuc) async {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        UiProvider stream = context.watch<UiProvider>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                            color: HexColor("#F4F6FA"),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: HexColor("#DFE5F3"))),
                        child: Padding(
                          padding: EdgeInsets.all(7.0),
                          child: Icon(
                            Icons.clear,
                            size: 15,
                            color: HexColor("#0A38A7"),
                          ),
                        ),
                      ),
                    ),
                    AppText(
                      text: isStatuc ? "FILTER BY STATUS" : "FILTER BY STAFF",
                      size: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    ...isStatuc
                        ? status.map((e) => CheckboxListTile(
                            title: AppText(
                              text: e,
                              size: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            value: stream.orderFilter == e.toString()
                                ? true
                                : false,
                            onChanged: (val) {
                              UiProvider action = Provider.of<UiProvider>(
                                  context,
                                  listen: false);

                              if (e == "All") {
                                action.addOrderFilter("All");
                              } else {
                                action.addOrderFilter(e.toString());
                              }
                            }))
                        : staff.map((e) => CheckboxListTile(
                            title: AppText(
                              text: e,
                              size: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            value: false,
                            onChanged: (val) {}))
                  ],
                )
              ],
            ),
          ),
        );
      });
}
