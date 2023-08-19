import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/generalwidgets/button.dart';
import 'package:salesapp/presentation/generalwidgets/text.dart';
import 'package:salesapp/services/api_url.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../../uiproviders/ui_provider.dart';

dateFilter(
  BuildContext context,
) async {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => PageRouting.popToPage(context),
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
                        text: "FILTER BY DATE",
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      AppText(
                        text: "Clear",
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    ...datePicks.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: RadioListTile(
                              enableFeedback: true,
                              selectedTileColor: Colors.white,
                              controlAffinity: ListTileControlAffinity.trailing,
                              // shape: RoundedRectangleBorder(
                              //     side: BorderSide(color: HexColor("#DFE5F3")),
                              //     borderRadius: BorderRadius.circular(8)),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: e.title!,
                                    color: HexColor("#101828"),
                                    size: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  AppText(
                                    text:
                                        "${Operations.convertDate(e.date1!)} - ${Operations.convertDate(DateTime.now())}",
                                    color: HexColor("#667085"),
                                    size: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              value: stream.dateType,
                              groupValue: e.title,
                              onChanged: (val) {
                                UiProvider ui = Provider.of<UiProvider>(context,
                                    listen: false);
                                ui.addDate(e.date1!, e.title!);
                              }),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        UiProvider ui =
                            Provider.of<UiProvider>(context, listen: false);
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now()
                                .subtract(Duration(days: 7)), //get today's date
                            firstDate: DateTime(
                                1970), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          ui.addStartDate(pickedDate);
                          // print(
                          //     pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                          // format date in required form here we use yyyy-MM-dd that means time is removed
                          //  print(formattedDate);
                          // setState(() {
                          //   formattedDate = DateFormat('MM-yyyy').format(pickedDate);
                          // });
                          // print(
                          //     formattedDate); //formatted date output using intl package =>  2022-07-04
                          //You can format date as per your need

                          // print(pickedDate.month.toString());
                          // print(pickedDate.year.toString());

                          // setState(() {
                          //   dateController.text =
                          //       formattedDate; //set foratted date to TextField value.
                          // });

                          //   await Operations.funcChangeDob(context, pickedDate);
                        } else {
                          print("Date is not selected");
                        }
                      },
                      child: Container(
                        height: 63,
                        width: 150,
                        decoration: BoxDecoration(
                            color: HexColor("#F9FAFB"),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: HexColor("#DFE5F3"))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AppText(
                                  text: "From",
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#475467"),
                                ),
                                AppText(
                                  text: stream.startDate == null
                                      ? "-"
                                      : Operations.convertDate(
                                          stream.startDate!),
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#475467"),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        UiProvider ui =
                            Provider.of<UiProvider>(context, listen: false);
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate: DateTime(
                                1970), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          consoleLog(pickedDate.toString());
                          // DateTime formattedDate = DateFormat('MM-yyyy').format(pickedDate);
                          ui.addEndDate(pickedDate);
                          // print(
                          //     pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                          // format date in required form here we use yyyy-MM-dd that means time is removed
                          //  print(formattedDate);
                          // setState(() {
                          //   formattedDate = DateFormat('MM-yyyy').format(pickedDate);
                          // });
                          // print(
                          //     formattedDate); //formatted date output using intl package =>  2022-07-04
                          //You can format date as per your need

                          // print(pickedDate.month.toString());
                          // print(pickedDate.year.toString());

                          // setState(() {
                          //   dateController.text =
                          //       formattedDate; //set foratted date to TextField value.
                          // });

                          //   await Operations.funcChangeDob(context, pickedDate);
                        } else {
                          print("Date is not selected");
                        }
                      },
                      child: Container(
                        height: 63,
                        width: 150,
                        decoration: BoxDecoration(
                            color: HexColor("#F9FAFB"),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: HexColor("#DFE5F3"))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AppText(
                                  text: "To",
                                  size: 12,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#475467"),
                                ),
                                AppText(
                                  text: stream.endDate == null
                                      ? "-"
                                      : Operations.convertDate(stream.endDate!),
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor("#475467"),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                  backColor: blue,
                  onTap: () {
                    UiProvider ui =
                        Provider.of<UiProvider>(context, listen: false);
                    if (ui.dateType == "Custom") {
                      if (ui.startDate == null || ui.endDate == null) {
                        showToast("Please set start and end dates",
                            context: context,
                            backgroundColor: red,
                            // textStyle: TextStyle(color: blue),
                            duration: Duration(seconds: 5),
                            position: StyledToastPosition.top);
                      } else {
                        PageRouting.popToPage(context);
                      }
                    } else {
                      // consoleLog(ui.dateFilter.toString());
                      PageRouting.popToPage(context);
                    }
                  },
                  child: AppText(
                    text: "Apply Filter",
                    size: 14,
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      });
}

class DateFilterModel {
  String? title;
  DateTime? date1;

  DateFilterModel({this.date1, this.title});
}

List<DateFilterModel> datePicks = [
  DateFilterModel(
    date1: DateTime.now(),
    title: "Today",
  ),
  DateFilterModel(
    date1: DateTime.now().subtract(const Duration(days: 7)),
    title: "Last 7 days",
  ),
  DateFilterModel(
    date1: DateTime.now().subtract(const Duration(days: 30)),
    title: "Last 30 days",
  ),
  DateFilterModel(
    date1: DateTime(DateTime.now().year, 1, 1), //yyyy-MM-dd
    title: "This Year",
  ),
  DateFilterModel(
    date1: DateTime.now(),
    title: "Custom",
  ),
];
