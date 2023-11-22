import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/cart_model.dart';
import '../uimodels/desription_model.dart';

class UiProvider extends ChangeNotifier {
  bool _onGrid = false;
  bool get onGrid => _onGrid;
  String _type = "Retail";
  List<SalesModel> sales = [];
  String get type => _type;
  String paymentMethod = "";
  DateTime? dateFilter = DateTime(2005);
  String dateType = "";

  bool loadProd = false;

  int _qty = 1;
  int get qty => _qty;

  String note = "";
  String sn = "";
  String amount = "";
  var descAmount = 0.0;
  int orderTab = 0;
  bool loadOrder = false;

  String orderFilter = "";
  DateTime? startDate;
  DateTime? endDate;

  String draftSearch = "";

  void searchDraft(String search) {
    draftSearch = search;
    notifyListeners();
  }

  void addStartDate(DateTime time) {
    startDate = time;
    notifyListeners();
  }

  void addEndDate(DateTime time) {
    endDate = time;
    notifyListeners();
  }

  void addOrderFilter(String val) {
    orderFilter = val;
    notifyListeners();
  }

  void loadProducts(bool val) {
    loadProd = val;
    notifyListeners();
  }

  void loadOrderUpload(bool val) {
    loadOrder = val;
    notifyListeners();
  }

  void changeTab(int tab) => {orderTab = tab, notifyListeners()};

  void addPayment(String pay) => {paymentMethod = pay, notifyListeners()};
  void addDate(DateTime date, String title) =>
      {dateFilter = date, dateType = title, notifyListeners()};

  void changeView() =>
      {_onGrid ? _onGrid = false : _onGrid = true, notifyListeners()};

  void selectType(String name) => {_type = name, notifyListeners()};
  void addWholeSale(SalesModel data) => {sales.add(data), notifyListeners()};
  void removeWholeSale() => {sales = [], sales.clear(), notifyListeners()};
  void qtyModify(bool isAdded, int ad, int amount) async {
    if (isAdded) {
      _qty += ad;
      descAmount += amount;
    } else {
      if ((_qty - ad) < 0) {
        _qty -= 0;
      } else {
        _qty -= ad;
        descAmount -= amount;
      }
    }
    // isAdded == false && _qty > 0
    //     ? _qty--
    //     : isAdded
    //         ? _qty++
    //         : _qty = 0,
    notifyListeners();
  }

  void initAmount(double a) {
    descAmount = a;
    notifyListeners();
  }

  void addSn(String data) {
    sn = data;
    notifyListeners();
  }

  void addNote(String data) {
    note = data;
    notifyListeners();
  }

  void addAmount(String data) {
    amount = data;
    notifyListeners();
  }

  void clearDesc() {
    note = "";
    sn = "";
    amount = "";
    _qty = 0;
    notifyListeners();
  }
}

class DescriprionController extends GetxController {
  static DescriprionController get instance {
    return Get.find<DescriprionController>();
  }

  RxList<SalesModel> sales = <SalesModel>[].obs;

  void addWholeSale(SalesModel data) => {sales.add(data)};

  void selectPrice(id) async {
    final find = sales
        .where((p0) => p0.wholeSale!.id.toString() == id.toString())
        .toList();
    if (find.isNotEmpty) {
      sales.forEach((element) {
        element.selected!.value = false;
      });
      update();
      if (find.first.selected!.value == true) {
        find.first.selected!.value == false;
      } else {
        find.first.selected!.value = true;
      }
    }
    update();
  }

  void addQtySale(id, int data, bool isAdd, int stock) {
    final find = sales
        .where((p0) => p0.wholeSale!.id.toString() == id.toString())
        .toList();

    if (find.isNotEmpty) {
      int finalQtyAdded = 0;
      int finalQtyRemoved = 0;
      for (var element in sales) {
        finalQtyAdded += element.qty!.value;
        //    finalQtyRemoved = (stock -= element.qty!.value);
      }
      finalQtyRemoved = stock - finalQtyAdded;
      print(finalQtyRemoved);
      if (isAdd) {
        if ((finalQtyAdded + data) > stock) {
          find.first.qty!.value += 0;
        } else {
          find.first.qty!.value += data;
          find.first.amount =
              (find.first.wholeSale!.price * find.first.qty!.value).toString();
          find.first.subAmount.value.text =
              (find.first.wholeSale!.price * find.first.qty!.value).toString();
        }
      } else {
        if ((finalQtyRemoved + data) > stock) {
          find.first.qty!.value -= 0;
        } else {
          if ((find.first.qty!.value - data).isNegative ||
              (find.first.qty!.value - data) < 0) {
            return;
          } else {
            find.first.qty!.value -= data;
            find.first.amount =
                (find.first.wholeSale!.price * find.first.qty!.value)
                    .toString();
            find.first.subAmount.value.text =
                (find.first.wholeSale!.price * find.first.qty!.value)
                    .toString();
          }
        }
      }
    }
    update();
  }

  void updatePrice(id, data) {
    final find = sales
        .where((p0) => p0.wholeSale!.id.toString() == id.toString())
        .toList();
    if (find.isNotEmpty) {
      find.first.amount = data.toString();
    }
  }

  void removeWholeSale() => {
        sales.value = [],
        sales.clear(),
      };
}
