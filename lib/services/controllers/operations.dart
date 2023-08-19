// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:salesapp/presentation/generalwidgets/no_barcode.dart';
import 'package:salesapp/presentation/uiproviders/ui_provider.dart';
import 'package:salesapp/services/controllers/product_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/product_model.dart';
import '../../presentation/constant/colors.dart';
import '../../presentation/functions/allNavigation.dart';
import '../../presentation/generalwidgets/invoice/api/pdf_api.dart';
import '../../presentation/generalwidgets/invoice/api/pdf_invoice_api.dart';
import '../../presentation/generalwidgets/invoice/model/customer.dart';
import '../../presentation/generalwidgets/invoice/model/invoice.dart';
import '../../presentation/generalwidgets/invoice/model/supplier.dart';
import '../../presentation/screens/description/description.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/onboard/login_screen.dart';
import '../temps/temp_store.dart';
import 'cart_controller.dart';
import 'login_controller.dart';
import 'order_controller.dart';

class Operations {
  static Future delayScreen(BuildContext context, Widget page) async {
    await Future.delayed(const Duration(seconds: 2), () {})
        .whenComplete(() => PageRouting.removeAllToPage(context, page));
  }

  static Future barcodeScan(BuildContext context) async {
    String code = 'Unknown';
    ProductProvider prod = Provider.of<ProductProvider>(context, listen: false);

    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#0000FF',
        'Cancel',
        true,
        ScanMode.QR,
      );

      //  if (!mounted) return;

      code = qrCode;
      //   log(qrCode);

      if (qrCode.length > 2) {
        FocusScope.of(context).unfocus();
        //     FocusScope.of(context).dispose();

        List<ProductDatum> findProduct = prod.shopProduct.where((element) {
          return element.productUnit!.barcode
              .toString()
              .toLowerCase()
              .contains(qrCode.toString().toLowerCase());
        }).toList();

        if (findProduct.isEmpty) {
          noBarcodeFound(context,
              "Can't find this Product. Try another barcode", "Not Found", red);
        } else {
          await showDiscription(context, findProduct.first);
        }

        //FocusScope.of(context).dispose();

        // PageRouting.pushToPage(
        //   context,
        //   ProductSearchResult(
        //     catId: widget.id!,
        //     isCategory: widget.isCategory!,
        //     controller: qrCode,
        //     isBarCode: true,
        //   ));
      }
    } on PlatformException {
      code = 'Failed to get platform version.';
    }
  }

  static Future<void> checkSessionStat(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.containsKey(TempStore.tokenKey) &&
        pref.containsKey(TempStore.isLoggedInKey)) {
      await LoginController.makeRequest(context);
    } else {
      delayScreen(context, const LoginScreen());
    }
  }

  static Future toggleViews(context) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    ui.changeView();
  }

  static Future addType(context, String name) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    ui.selectType(name);
  }

  static Future addQAty(context, bool isAdded, [int? qty, int? amount]) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    ui.qtyModify(isAdded, qty!, amount!);
  }

  static Future addNoteCart(context, String data) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    ui.addNote(data);
  }

  static Future addSnCart(context, String data) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    ui.addSn(data);
  }

  static Future addAmountCart(context, String data) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    ui.addAmount(data);
  }

  static Future clearFields(context) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    ui.clearDesc();
  }

  static Future addAmountStart(context, amount) async {
    UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    ui.initAmount(double.tryParse(amount.toString())!);
  }

  static String convertDate(DateTime date) {
    late String newDate;
    if (date.month == 1) {
      newDate = "Jan";
    } else if (date.month == 2) {
      newDate = "Feb";
    } else if (date.month == 3) {
      newDate = "Mar";
    } else if (date.month == 4) {
      newDate = "Apr";
    } else if (date.month == 5) {
      newDate = "May";
    } else if (date.month == 6) {
      newDate = "Jun";
    } else if (date.month == 7) {
      newDate = "Jul";
    } else if (date.month == 8) {
      newDate = "Aug";
    } else if (date.month == 9) {
      newDate = "Sep";
    } else if (date.month == 10) {
      newDate = "Oct";
    } else if (date.month == 11) {
      newDate = "Nov";
    } else if (date.month == 12) {
      newDate = "Dec";
    }

    return "$newDate ${date.day}, ${date.year} - ${date.hour}:${date.minute}";
  }

  static cleaarSearch(context) {
    OrderProvider order = Provider.of<OrderProvider>(context, listen: false);
    order.searchOrder("");
  }

  static Future<void> openPdf(context, String name, String satus,
      String orderNum, double amount, String bank, String pos, String cash,
      [bool? isOrder, String? paid]) async {
    OrderProvider prod = Provider.of<OrderProvider>(context, listen: false);
    LoginProvider userData = Provider.of<LoginProvider>(context, listen: false);

    // ShopSettingsModel shop =
    //     Provider.of<ShopSettingsModel>(context, listen: false);
    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));

    final invoice = Invoice(
        supplier: Supplier(
          name: name,
          address: '',
          paymentInfo: satus,
        ),
        customer: Customer(
          name: name,
          address: "",
        ),
        info: InvoiceInfo(
          name: userData.shopModel.data!.shop!.name ?? "Ogaboss",
          date: date,
          dueDate: dueDate,
          description:
              "${userData.shopModel.data!.user!.email ?? "no mail"} | ${userData.shopModel.data!.user!.contactNo ?? "no number"}",
          number: "REG: $orderNum",
        ),
        items: prod.orders
            .where((element) => element.orderNumber == orderNum)
            .first
            .cart!
            .cartItems!
            .map(
              (e) => InvoiceItem(
                  description: e.shopProduct!.product!.name!,
                  date: DateTime.now(),
                  quantity: e.quantity!,
                  vat: 0.toDouble(),
                  unitPrice: double.tryParse(e.price!)!,
                  content: "IMEI: "),
            )
            .toList(),
        subTotal: "N${convertToCurrency(amount.toString())}",
        bank: isOrder == true
            ? "N${convertToCurrency(paid!)}"
            : "N${convertToCurrency((double.tryParse(bank)! + double.tryParse(pos)! + double.tryParse(cash)!).toString())}",
        change: (amount -
                    double.tryParse(bank)! -
                    double.tryParse(pos)! -
                    double.tryParse(cash)!)
                .isNegative
            ? "N${convertToCurrency((amount - double.tryParse(bank)! - double.tryParse(pos)! - double.tryParse(cash)!).toString())}"
            : "N0.0",
        total: "N${convertToCurrency(amount.toString())}",
        vat: "0.0",
        remain: (amount -
                    (double.tryParse(bank)! +
                        double.tryParse(pos)! +
                        double.tryParse(cash)!))
                .isNegative
            ? "N0.0"
            : "N${convertToCurrency((amount - (double.tryParse(bank)! + double.tryParse(pos)! + double.tryParse(cash)!)).toString())}");

    final pdfFile = await PdfInvoiceApi.generate(invoice);

    PdfApi.openFile(pdfFile);
  }

  static Future<void> shareFile(context, String name, String satus,
      String orderNum, double amount, String bank, String pos, String cash,
      [bool? isOrder, String? paid]) async {
    final date = DateTime.now();
    final dueDate = date.add(Duration(days: 7));

    OrderProvider prod = Provider.of<OrderProvider>(context, listen: false);
    LoginProvider userData = Provider.of<LoginProvider>(context, listen: false);

    // ShopSettingsModel shop =
    //     Provider.of<ShopSettingsModel>(context, listen: false);

    final invoice = Invoice(
        supplier: Supplier(
          name: name,
          address: '',
          paymentInfo: satus,
        ),
        customer: Customer(
          name: name,
          address: "",
        ),
        info: InvoiceInfo(
          name: userData.shopModel.data!.user!.firstName ?? "Ogaboss",
          date: date,
          dueDate: dueDate,
          description:
              "${userData.shopModel.data!.user!.email ?? "no mail"} | ${userData.shopModel.data!.user!.contactNo ?? "no number"}",
          number: "REG: $orderNum",
        ),
        items: prod.orders
            .where((element) => element.orderNumber == orderNum)
            .first
            .cart!
            .cartItems!
            .map(
              (e) => InvoiceItem(
                  description: e.shopProduct!.product!.name!,
                  date: DateTime.now(),
                  quantity: e.quantity!,
                  vat: 0.toDouble(),
                  unitPrice: double.tryParse(e.price!)!,
                  content: "IMEI: "),
            )
            .toList(),
        subTotal: "N${convertToCurrency(amount.toString())}",
        bank: isOrder == true
            ? "N${convertToCurrency(paid!)}"
            : "N${convertToCurrency((double.tryParse(bank)! + double.tryParse(pos)! + double.tryParse(cash)!).toString())}",
        change: (amount -
                    double.tryParse(bank)! -
                    double.tryParse(pos)! -
                    double.tryParse(cash)!)
                .isNegative
            ? "N${convertToCurrency((amount - double.tryParse(bank)! - double.tryParse(pos)! - double.tryParse(cash)!).toString())}"
            : "N0.0",
        total: "N${convertToCurrency(amount.toString())}",
        vat: "0.0",
        remain: (amount -
                    (double.tryParse(bank)! +
                        double.tryParse(pos)! +
                        double.tryParse(cash)!))
                .isNegative
            ? "N0.0"
            : "N${convertToCurrency((amount - (double.tryParse(bank)! + double.tryParse(pos)! + double.tryParse(cash)!)).toString())}");

    final pdfFile = await PdfInvoiceApi.generate(invoice);

    await Share.shareFiles([pdfFile.path],
        text: 'Purchase invoice', subject: 'Invoice');
  }
}
