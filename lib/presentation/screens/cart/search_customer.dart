import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/constant/colors.dart';
import 'package:salesapp/services/controllers/customer_controller.dart';

import '../../../model/customer_model.dart';
import '../../generalwidgets/form_field.dart';
import '../../generalwidgets/text.dart';

class CustomerSearch extends StatefulWidget {
  final TextEditingController? controller;
  const CustomerSearch({super.key, this.controller});
  @override
  State<CustomerSearch> createState() => _CustomerSearchState();
}

class _CustomerSearchState extends State<CustomerSearch> {
  TextEditingController customer = TextEditingController();
  FocusNode fn = FocusNode();
  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      customer = widget.controller!;
      setState(() {
        customer = widget.controller!;
      });
    }
    // SchedulerBinding.instance.addPersistentFrameCallback((_) {
    //   if (mounted) {
    //     FocusScope.of(context).requestFocus(fn);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    CustomerProvider stream = context.watch<CustomerProvider>();

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        Navigator.pop(context, customer);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.15,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        //  setState(() {
                        //     customer =
                        //         TextEditingController(text: data.name ?? "");
                        //   });
                        Navigator.pop(context, customer);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: SvgPicture.asset(
                          "assets/icon/arrow-left.svg",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AppText(
                      text: "Customer",
                      color: HexColor("#475467"),
                      fontWeight: FontWeight.w500,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              preferredSize: Size(w, 48),
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 20.0, left: 10, right: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppFormField(
                      width: w - w * 0.1,
                      hint: "Enter customer name",
                      action: "customer",
                      controller: customer,
                      isEnabled: true,
                      autoFocus: true,
                      focus: fn,
                    ),
                  ],
                ),
              )),
        ),
        body: stream.customer.data == null
            ? SizedBox.shrink()
            : stream.customer.data!.data == null
                ? const SizedBox.shrink()
                : ListView.builder(
                    itemCount: stream.customer.data!.data!.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Datum data = stream.customer.data!.data![index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            customer =
                                TextEditingController(text: data.name ?? "");
                          });
                          Navigator.pop(context, customer);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Container(
                            height: 64,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.contact_page_outlined,
                                      color: blue,
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 250),
                                            child: AppText(
                                              text: data.name ?? "",
                                              fontWeight: FontWeight.w500,
                                              size: 16,
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 250),
                                            child: AppText(
                                              text: data.phone ?? "",
                                              fontWeight: FontWeight.w400,
                                              size: 13,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
