import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:salesapp/model/product_model.dart';
import 'package:salesapp/presentation/generalwidgets/invoice/api/pdf_api.dart';
import 'package:salesapp/presentation/generalwidgets/invoice/api/utils.dart';
import 'package:salesapp/services/controllers/operations.dart';

import '../../../constant/colors.dart';
import '../../text.dart';
import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import 'dart:math' as rand;

class PdfInvoiceApi {
  static Future<File> generate(
    Invoice invoice,
  ) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(
          invoice,
        ),
        SizedBox(height: 2 * PdfPageFormat.cm),
        // buildTitle(invoice),
        buildInvoice(invoice),
        Divider(color: PdfColor.fromHex("#EAECF0")),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'ShopUrban_Invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  invoice.info.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: PdfColor.fromHex("#1D2939")),
                ),
                SizedBox(height: 5),
                Text(
                  invoice.info.number,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: PdfColor.fromHex("#667085")),
                ),
                SizedBox(height: 5),
                Text(
                  invoice.info.description,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: PdfColor.fromHex("#667085")),
                ),
                SizedBox(height: 15),
              ])
            ],
          ),
          Column(children: [
            Text(
              "INVOICE",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: PdfColor.fromHex("#475467")),
            ),
            SizedBox(height: 1 * PdfPageFormat.cm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                invoicKey(),
                buildInvoiceInfo(
                  invoice.supplier,
                ),
              ],
            ),
          ])
        ],
      );

  static Widget invoicKey() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Billed to:".toLowerCase(),
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "INVOICE No:".toLowerCase(),
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "INVOICE DATE:".toLowerCase(),
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "status",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
        ],
      );

  static Widget buildInvoiceInfo(
    Supplier info,
  ) {
    String r = rand.Random().nextInt(999999).toString().padLeft(3, '0');
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(
        info.name.toLowerCase(),
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: PdfColor.fromHex("#667085")),
      ),
      Text(
        "INV-000$r".toLowerCase(),
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: PdfColor.fromHex("#667085")),
      ),
      Text(
        Operations.convertDate(DateTime.now()).toLowerCase(),
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: PdfColor.fromHex("#667085")),
      ),
      Text(
        info.paymentInfo,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: PdfColor.fromHex("#667085")),
      ),
    ]);
  }

  // static Widget buildSupplierAddress(Supplier supplier) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         Text(supplier.address),
  //       ],
  //     );

  // static Widget buildTitle(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'INVOICE',
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //         Text(invoice.info.description),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //       ],
  //     );

  static Widget buildInvoice(
    Invoice invoice,
  ) {
    final headers = [
      'Description',
      //  'Date',
      'Amount',

      //'VAT',
      //    'Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        "${item.quantity}x \n${item.description}",
        //  Utils.formatDate(order.createdAt!),

        'N${convertToCurrency(item.unitPrice.toString())}',
        //  '${item.vat}',
        //  'NGN ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.white),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = 300.0;

    final vat = 1.0;
    final total = 2200;

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Sub Total ",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "VAT @10%",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "Total:",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            invoice.subTotal,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            invoice.vat,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            invoice.total,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
        ])
      ]),
      Divider(color: PdfColor.fromHex("#EAECF0")),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Amount Paid",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "Change",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "Amount Due",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            invoice.bank,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            invoice.change,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
        ])
      ]),
      SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            Operations.convertDate(invoice.info.dueDate),
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            invoice.remain,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
        ])
      ])
    ]);
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(color: PdfColor.fromHex("#EAECF0")),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(children: [
            Text(
              "Notes",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: PdfColor.fromHex("#1D2939")),
            ),
          ]),
          SizedBox(height: 1.5 * PdfPageFormat.mm),
          Row(children: [
            Text(
              "Lorem ipsum dolor sit amet conetur. A arcu lacus urna quam cursus suspendisse urna pellentesque.",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: PdfColor.fromHex("#667085")),
            ),
          ]),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
