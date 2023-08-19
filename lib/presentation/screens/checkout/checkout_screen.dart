import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/screens/checkout/checkout_amount.dart';
import 'package:salesapp/presentation/screens/checkout/payment_methods.dart';

import '../../generalwidgets/form_field.dart';
import '../../generalwidgets/text.dart';

class CheckOutScreen extends StatelessWidget {
  final double? amount;
  final String? customer;
  bool? isDraft;
  String? id;
  CheckOutScreen({super.key, this.amount, this.customer, this.isDraft, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          onPressed: () => PageRouting.popToPage(context),
          color: Colors.black,
        ),
        title: AppText(
          text: "Payment",
          color: HexColor("#475467"),
          fontWeight: FontWeight.w500,
          size: 20,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            AmountDue(
              myAmount: amount!,
            ),
            PayMentMethods(),
            CheckOutAmount(
              amount: amount!,
              customerName: customer!,
              isDraft: isDraft,
              id: 
              id,
            )
          ],
        ),
      ),
    );
  }
}
