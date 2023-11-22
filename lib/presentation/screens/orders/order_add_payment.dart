import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/functions/allNavigation.dart';
import 'package:salesapp/presentation/screens/checkout/checkout_amount.dart';
import 'package:salesapp/presentation/screens/checkout/payment_methods.dart';
import 'dart:math' as rand;
import '../../../model/order_model.dart';
import '../../../services/controllers/login_controller.dart';
import '../../../services/controllers/order_controller.dart';
import '../../../services/controllers/product_controller.dart';
import '../../generalwidgets/button.dart';
import '../../generalwidgets/form_field.dart';
import '../../generalwidgets/order_successful.dart';
import '../../generalwidgets/text.dart';
import '../../uiproviders/ui_provider.dart';

class OrderAddPaymentScreen extends StatelessWidget {
  final double? amount;
  final String? customer;
  String? id;
  OrdersData order;
  OrderAddPaymentScreen(
      {super.key, this.amount, this.customer, this.id, required this.order});

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
            PaymentAmount(
              amount: amount!,
              customerName: customer!,
              id: id,
              order: order,
            )
          ],
        ),
      ),
    );
  }
}

class PaymentAmount extends StatefulWidget {
  final double amount;
  final String customerName;
  String? id;
  OrdersData order;
  PaymentAmount(
      {super.key,
      required this.amount,
      required this.customerName,
      this.id,
      required this.order});

  @override
  State<PaymentAmount> createState() => _PaymentAmountState();
}

class _PaymentAmountState extends State<PaymentAmount> {
  TextEditingController cash = TextEditingController();
  TextEditingController bank = TextEditingController();
  TextEditingController pos = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OrderProvider orders = context.watch<OrderProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          AppFormField(
            hint: "0.0",
            fieldName: "Cash",
            color: Colors.white,
            controller: cash,
            fieldSize: 14,
            isNumber: true,
          ),
          const SizedBox(
            height: 16,
          ),
          AppFormField(
            hint: "0.0",
            fieldName: "Bank Transfer",
            color: Colors.white,
            controller: bank,
            fieldSize: 14,
            isNumber: true,
          ),
          const SizedBox(
            height: 16,
          ),
          AppFormField(
            hint: "0.0",
            fieldName: "POS",
            color: Colors.white,
            isNumber: true,
            fieldSize: 14,
            controller: pos,
          ),
          const SizedBox(
            height: 30,
          ),
          MyButton(
            width: 358,
            backColor: HexColor("#0A38A7"),
            onTap: () async {
              UiProvider ui = Provider.of<UiProvider>(context, listen: false);
              ProductProvider product = Provider.of(context, listen: false);
              LoginProvider userData = Provider.of(context, listen: false);
              late double customerPaid;
              // if (cash.text.isEmpty && bank.text.isEmpty && pos.text.isEmpty) {
              //   showToast("Add amount",
              //       context: context,
              //       backgroundColor: Colors.red[900],
              //       position: StyledToastPosition.top);
              //   return;
              // }
              if (ui.paymentMethod.isEmpty) {
                showToast("Select payment method",
                    context: context,
                    backgroundColor: Colors.red[900],
                    position: StyledToastPosition.top);

                return;
              }
              customerPaid = 0.0;
              if (cash.text.isNotEmpty) {
                customerPaid +=
                    double.tryParse(cash.text.isEmpty ? "0.0" : cash.text)!;
              }
              if (bank.text.isNotEmpty) {
                customerPaid +=
                    double.tryParse(bank.text.isEmpty ? "0.0" : bank.text)!;
              }
              if (pos.text.isNotEmpty) {
                customerPaid +=
                    double.tryParse(pos.text.isEmpty ? "0.0" : pos.text)!;
              }
              final amountPaid =
                  double.tryParse(cash.text.isEmpty ? "0.0" : cash.text)! +
                      double.tryParse(bank.text.isEmpty ? "0.0" : bank.text)! +
                      double.tryParse(pos.text.isEmpty ? "0.0" : pos.text)!;
              String r =
                  rand.Random().nextInt(999999).toString().padLeft(5, '0');

              try {
                Payment payment = Payment(
                    amount: amountPaid,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    isConfirmed: 1,
                    paymentType: ui.paymentMethod,
                    id: int.tryParse(r),
                    userId: userData.shopModel.data!.user!.id!,
                    orderNumberTrack: widget.order.orderNumber);
                await OrderController.addPaymentOption(
                        context, payment, widget.order.id.toString())
                    .whenComplete(() {
                  setState(() {});
                  showToast("Payment added",
                      context: context,
                      backgroundColor: Colors.blue[900],
                      position: StyledToastPosition.top);
                  Navigator.pop(context, null);
                });
              } catch (e) {
                showToast("$e",
                    context: context,
                    backgroundColor: Colors.red[900],
                    position: StyledToastPosition.top);
              }
            },
            child: AppText(
              text: "Add",
              color: HexColor("#FFFFFF"),
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

// bool balanced(String s) {
  
//   var valueHolder = []; //new list => used later in line 43
//   var numHolder = [];
//   var newS = []; //newS == new string
//     var boolValue = [];
//   bool isBalanced;
//     int allValLength = 0;
  
//   if(s.isEmpty){
//     isBalanced = true;
//   }
//  //split the string to make it loopable
//   var array = s.split('').toList();
  
//     var array2 = array.forEach((element) {
//       // check to avoid repetition of characters
//       if( newS.length <= s.length){
        
//           newS.add(element);
//       }
     
  
//   });
  
//   // declare and initialize a map to hold key values
//   var map = Map();

//   for (var element in newS) {
//    // condifional statement to check if character is upper case or lower case
//     if (element == element.toLowerCase()) {
//       if (map.containsKey(element)) {
//         map[element] += 1; // increment value if it exist already based on how many times the value appears in the string
//       } else {
//         map[element] = 1;
//       }
//     } else {
//       if (map.containsKey(element)) {
//         map[element] += 1;
//       } else {
//         map[element] = 1;
//       }
//     }
//     //transfer all values into new list
//     valueHolder.add(element);

//   }
//   //clear old list
//   newS.clear();

//   // iterate through new list
//   for (var value in valueHolder) {
 
//     numHolder.add(map[value]); // add each map key value in new list 
//   }
//   valueHolder.clear(); // clear list


//   // loop through the repition values
//   for (var i in numHolder) {
  
//     if (i % 2 == 0) {
//       boolValue.add("true"); // add to "true" to list if value is divisible by 2
    
//     } else {
//       boolValue.add("false");
        
//     }
//   }
//   numHolder.clear();

//   if (boolValue.contains("false")) {
 
//     for(var value in boolValue){
//       if(value == "false"){
//         allValLength +=1;
   
//       }else{
//          allValLength = 0;   
//       }
//     }
//     if(allValLength == boolValue.length){
//           isBalanced =  true;
//     }else{
//           isBalanced =  false;
//     }

//   } else {
//     isBalanced =  true;
//   }
//   boolValue.clear();
 
  
//   return isBalanced;
// }
