import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  bool _onGrid = false;
  bool get onGrid => _onGrid;
  String _type = "Retail";
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
