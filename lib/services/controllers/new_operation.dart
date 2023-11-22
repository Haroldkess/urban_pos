import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../model/product_model.dart';
import '../../presentation/uimodels/desription_model.dart';
import '../../presentation/uiproviders/ui_provider.dart';

class WholeSaleOperation {
  static Future removeAndAddWholeSale(
      context, List<ShopProductWholesalePrice>? data, ProductDatum prod) async {
    //UiProvider ui = Provider.of<UiProvider>(context, listen: false);
    if (data == null) {
      return;
    } else {
      DescriprionController.instance.removeWholeSale();
      DescriprionController.instance.addWholeSale(SalesModel(
        amount: "0.0",
        qty: 0.obs,
        subAmount: TextEditingController().obs,
        initialQty: 1,
        wholeSale: ShopProductWholesalePrice(
            id: 0,
            price: prod.sellPrice,
            wholesaleQuantity: 1,
            shopProductId: prod.id,
            costPrice: prod.costPrice,
            name: "Single"),
        id: 0,
        selected: true.obs,
      ));
      if (data.isEmpty) return;
      await Future.forEach(
          data,
          (element) => DescriprionController.instance.addWholeSale(SalesModel(
                amount: "0.0",
                qty: 0.obs,
                initialQty: element.wholesaleQuantity!,
                wholeSale: element.copyWith(
                    name:
                        element.name ?? "Pack of ${element.wholesaleQuantity}"),
                subAmount: TextEditingController().obs,
                id: 0,
                selected: false.obs,
              )));

      // DescriprionController.instance.selectPrice(data.first.id);
    }
  }
}
