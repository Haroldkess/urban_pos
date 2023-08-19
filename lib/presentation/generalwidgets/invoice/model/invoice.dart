import 'package:salesapp/presentation/generalwidgets/invoice/model/supplier.dart';

import 'customer.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;
  final String subTotal;
  final String vat;
  final String total;
  final String bank;
  final String change;
  final String remain;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
    required this.subTotal,
    required this.vat,
    required this.bank,
    required this.total,
    required this.change,
    required this.remain
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final String name;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.name,
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;
  final double vat;
  final double unitPrice;
  final String content;

  const InvoiceItem(
      {required this.description,
      required this.date,
      required this.quantity,
      required this.vat,
      required this.unitPrice,
      required this.content});
}
