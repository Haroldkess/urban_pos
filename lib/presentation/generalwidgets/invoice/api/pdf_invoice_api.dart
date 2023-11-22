import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
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

class AmountModel {
  String? title;
  String? value;
  AmountModel({this.title, this.value});
}

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
        SizedBox(height: 1 * PdfPageFormat.cm),
        // buildTitle(invoice),
        buildInvoice(invoice),
        //  Divider(color: PdfColor.fromHex("#EAECF0")),
        SizedBox(height: 0.4 * PdfPageFormat.cm),
        buildTotal(invoice),
        SizedBox(height: 1.5 * PdfPageFormat.cm),
        termsAndConditions(),
        SizedBox(height: 2 * PdfPageFormat.cm),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'ShopUrban_Invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: ClipOval(
              child: pw.ClipRRect(
                horizontalRadius: 10,
                verticalRadius: 10,
                child: pw.Image(invoice.image!!),
              ),
            ),
          ),
          // PdfImage(pdfDocument, image: image, width: width, height: height)
          // CircleAvatar(
          //                       radius: 30,
          //                       backgroundColor: HexColor("#CED7ED"),
          //                       backgroundImage: CachedNetworkImageProvider(invoice.image
          //                                ??
          //                           "https://pbs.twimg.com/profile_images/1583237430718697472/58HiJ5OO_400x400.jpg"),
          //                     ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 1 * PdfPageFormat.cm),
              Text(
                "INVOICE",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: PdfColor.fromHex("#475467")),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      invoice.info.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: PdfColor.fromHex("#1D2939")),
                    ),
                    SizedBox(height: 5),
                    Text(
                      invoice.supplier.address ?? "Location undefined",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: PdfColor.fromHex("#667085")),
                    ),
                    SizedBox(height: 5),
                    Text(
                      invoice.info.description,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: PdfColor.fromHex("#667085")),
                    ),
                    SizedBox(height: 5),
                  ])
                ],
              ),
              Column(children: [
                SizedBox(height: 0.5 * PdfPageFormat.cm),
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
          )
        ]);
  }

  static Widget invoicKey() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text(
          //   "Billed to:".toLowerCase(),
          //   style: TextStyle(
          //       fontWeight: FontWeight.normal,
          //       fontSize: 12,
          //       color: PdfColor.fromHex("#667085")),
          // ),
          Text(
            "INVOICE No:".toLowerCase(),
            // textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "INVOICE DATE:".toLowerCase(),
            // textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: PdfColor.fromHex("#667085")),
          ),
          Text(
            "status:",
            //     textAlign: TextAlign.left,
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
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
        "  ${info.paymentInfo}",
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
            color: PdfColor.fromHex("#667085")),
      ),
    ]);
  }

  static Widget termsAndConditions() {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
          width: PdfPageFormat.standard.width,
          color: PdfColors.grey.shade(.1),
          height: 30,
          child: Row(children: [
            SizedBox(width: 5),
            Text(
              "Terms & Conditions",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: PdfColor.fromHex("#475467")),
            ),
          ])),
      SizedBox(height: 10),
      Container(
        width: PdfPageFormat.standard.width,
        child: Text(
          "No Refund of Money After Payment. Buy don buy sell don sell. No Refund of Money After Payment. Buy don buy sell don sell. No Refund of Money After Payment. Buy don buy sell don sell. No Refund of Money After Payment. Buy don buy sell don sell. No Refund of Money After Payment. Buy don buy sell don sell. No Refund of Money After Payment. Buy don buy sell don sell. ",
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 10,
              color: PdfColor.fromHex("#667085")),
        ),
      )
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
      'DESCRIPTION',
      'QTY    ',
      //   'PRICE',
      'AMOUNT',

      //'VAT',
      //    'Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        (item.description),

        //  Utils.formatDate(order.createdAt!),
        "${item.quantity}",

        'N${convertToCurrency(item.unitPrice.toString())}',

        //  '${item.vat}',
        //  'NGN ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      // rowDecoration:
      //     BoxDecoration(border: Border.all(width: 1.5, color: PdfColors.grey)),
      border: TableBorder(
        horizontalInside: BorderSide(color: PdfColors.grey200, width: 1.5),
        bottom: BorderSide(color: PdfColors.grey200, width: 1.5),
        left: BorderSide(color: PdfColors.grey200, width: 1.5),
        right: BorderSide(color: PdfColors.grey200, width: 1.5),
      ),

      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(
          color: PdfColors.grey.shade(.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          )),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    List<AmountModel> listData = [
      AmountModel(title: "Amount Tendered", value: "${invoice.amountTendered}"),
      AmountModel(title: "Cash", value: "${invoice.cash}"),
      AmountModel(title: "Bank Transfer", value: "${invoice.bank}"),
      AmountModel(title: "Pos", value: "${invoice.pos}"),
      AmountModel(title: "Change", value: "${invoice.change}"),
    ];
    final headers = [
      'Payment details',
      '    ',
      //   'PRICE',
      //    'AMOUNT',

      //'VAT',
      //    'Total'
    ];
    //  final data = [""].toList();
    final data = listData.map((item) {
      return [
        (item.title),

        //  Utils.formatDate(order.createdAt!),

        '${item.value}',

        //  '${item.vat}',
        //  'NGN ${total.toStringAsFixed(2)}',
      ];
    }).toList();
    return Container(
        width: PdfPageFormat.standard.width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: PdfPageFormat.standard.width / 2.5,
                  child: Table.fromTextArray(
                    headers: headers,
                    data: data,
                    cellStyle: TextStyle(fontWeight: FontWeight.normal),
                    // rowDecoration:
                    //     BoxDecoration(border: Border.all(width: 1.5, color: PdfColors.grey)),
                    border: TableBorder(
                      // horizontalInside: BorderSide(color: PdfColors.grey200, width: 1.5),
                      bottom: BorderSide(color: PdfColors.grey200, width: 1.5),
                      left: BorderSide(color: PdfColors.grey200, width: 1.5),
                      right: BorderSide(color: PdfColors.grey200, width: 1.5),
                    ),

                    headerStyle: TextStyle(fontWeight: FontWeight.bold),
                    headerDecoration: BoxDecoration(
                        color: PdfColors.grey.shade(.1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        )),
                    cellHeight: 30,
                    cellAlignments: {
                      0: Alignment.centerLeft,
                      1: Alignment.centerRight,
                      2: Alignment.centerRight,
                      3: Alignment.centerRight,
                      4: Alignment.centerRight,
                      5: Alignment.centerRight,
                    },
                  )),
              Container(
                  width: PdfPageFormat.standard.width / 2.7,
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sub Total ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: PdfColor.fromHex("#667085")),
                                    ),
                                    Text(
                                      "VAT @0%",
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
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
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
                        SizedBox(height: 10),

                        Text(
                          invoice.totalAmountInWords ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: PdfColor.fromHex("#667085")),
                        ),

                        // Divider(color: PdfColor.fromHex("#EAECF0")),
                        // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        //   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        //     Text(
                        //       "Amount Paid",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 12,
                        //           color: PdfColor.fromHex("#667085")),
                        //     ),
                        //     Text(
                        //       "Change",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 12,
                        //           color: PdfColor.fromHex("#667085")),
                        //     ),
                        //     Text(
                        //       "Amount Due",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 12,
                        //           color: PdfColor.fromHex("#667085")),
                        //     ),
                        //   ]),
                        //   Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        //     Text(
                        //       invoice.bank,
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 12,
                        //           color: PdfColor.fromHex("#667085")),
                        //     ),
                        //     Text(
                        //       invoice.change,
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 12,
                        //           color: PdfColor.fromHex("#667085")),
                        //     ),
                        //   ])
                        // ]),
                        // SizedBox(height: 10),
                        // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        //   Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        //     Text(
                        //       Operations.convertDate(invoice.info.dueDate),
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 12,
                        //           color: PdfColor.fromHex("#667085")),
                        //     ),
                        //     Text(
                        //       invoice.remain,
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.normal,
                        //           fontSize: 12,
                        //           color: PdfColor.fromHex("#667085")),
                        //     ),
                        //   ])
                        // ])
                      ]))
            ]));
  }

  static Widget buildFooter(Invoice invoice) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(width: 150, height: 1, color: PdfColors.black),
            SizedBox(height: 10),
            Text(
              "Customer Signature",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: PdfColor.fromHex("#667085")),
            ),
          ]),
          Column(children: [
            Container(width: 150, height: 2, color: PdfColors.black),
            SizedBox(height: 10),
            Text(
              "Customer Signature",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: PdfColor.fromHex("#667085")),
            ),
          ]),
          // Divider(color: PdfColor.fromHex("#EAECF0")),
          // SizedBox(height: 2 * PdfPageFormat.mm),
          // Row(children: [
          //   Text(
          //     "Notes",
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         fontSize: 10,
          //         color: PdfColor.fromHex("#1D2939")),
          //   ),
          // ]),
          // SizedBox(height: 1.5 * PdfPageFormat.mm),
          // Row(children: [
          //   Text(
          //     "Lorem ipsum dolor sit amet conetur. A arcu lacus urna quam cursus suspendisse urna pellentesque.",
          //     style: TextStyle(
          //         fontWeight: FontWeight.normal,
          //         fontSize: 10,
          //         color: PdfColor.fromHex("#667085")),
          //   ),
          // ]),
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
