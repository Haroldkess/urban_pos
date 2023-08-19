// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? status;
  List<ProductDatum>? data;
  bool? success;
  String? message;

  ProductModel({
    this.status,
    this.data,
    this.success,
    this.message,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ProductDatum>.from(
                json["data"]!.map((x) => ProductDatum.fromJson(x))),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
        "message": message,
      };
}

class ProductDatum {
  dynamic id;
  int? shopId;
  int? productUnitId;
  int? productId;
  int? categoryId;
  dynamic costPrice;
  dynamic sellPrice;
  int? restockAlert;
  dynamic attributes;
  DateTime? expiredDate;
  int? stockCount;
  dynamic otherDetails;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;
  ProductUnit? productUnit;
  List<ShopProductWholesalePrice>? shopProductWholesalePrices;
  List<dynamic>? shopProductSerialNos;
  String? serialNo;
  String? newPrice;
  int? qty;
  // String? soldBy;
  // String? orderNo;
  // String? status;
  

  ProductDatum(
      {this.id,
      this.shopId,
      this.productUnitId,
      this.productId,
      this.categoryId,
      this.costPrice,
      this.sellPrice,
      this.restockAlert,
      this.attributes,
      this.expiredDate,
      this.stockCount,
      this.otherDetails,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.productUnit,
      this.shopProductWholesalePrices,
      this.shopProductSerialNos,
      this.serialNo,
      this.newPrice,
      this.qty});

  ProductDatum copyWith({
    dynamic id,
    int? shopId,
    int? productUnitId,
    int? productId,
    int? categoryId,
    int? costPrice,
    dynamic sellPrice,
    int? restockAlert,
    int? attributes,
    DateTime? expiredDate,
    int? stockCount,
    dynamic otherDetails,
    dynamic deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
    ProductUnit? productUnit,
    List<ShopProductWholesalePrice>? shopProductWholesalePrices,
    List<dynamic>? shopProductSerialNos,
    String? serialNo,
    String? newPrice,
    int? qty,
  }) =>
      ProductDatum(
          id: id ?? this.id,
          shopId: shopId ?? this.shopId,
          productUnitId: productUnitId ?? this.productUnitId,
          productId: productId ?? this.productId,
          categoryId: categoryId ?? this.categoryId,
          costPrice: costPrice ?? this.costPrice,
          sellPrice: sellPrice ?? this.sellPrice,
          restockAlert: restockAlert ?? this.restockAlert,
          attributes: attributes ?? this.attributes,
          expiredDate: expiredDate ?? this.expiredDate,
          stockCount: stockCount ?? this.stockCount,
          otherDetails: otherDetails ?? this.otherDetails,
          deletedAt: deletedAt ?? this.deletedAt,
          createdAt: createdAt ?? this.createdAt,
          updatedAt: updatedAt ?? this.updatedAt,
          product: product ?? this.product,
          productUnit: productUnit ?? this.productUnit,
          shopProductWholesalePrices:
              shopProductWholesalePrices ?? this.shopProductWholesalePrices,
          shopProductSerialNos:
              shopProductSerialNos ?? this.shopProductSerialNos,
          serialNo: serialNo ?? this.serialNo,
          newPrice: newPrice ?? this.newPrice,
          qty: qty ?? this.qty);

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json["id"],
        shopId: json["shop_id"],
        productUnitId: json["product_unit_id"],
        productId: json["product_id"],
        categoryId: json["category_id"],
        costPrice: json["cost_price"],
        sellPrice: json["sell_price"],
        restockAlert: json["restock_alert"],
        attributes: json["attributes"],
        expiredDate: json["expired_date"] == null
            ? null
            : DateTime.parse(json["expired_date"]),
        stockCount: json["stock_count"],
        otherDetails: json["other_details"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        productUnit: json["product_unit"] == null
            ? null
            : ProductUnit.fromJson(json["product_unit"]),
        shopProductWholesalePrices:
            json["shop_product_wholesale_prices"] == null
                ? []
                : List<ShopProductWholesalePrice>.from(
                    json["shop_product_wholesale_prices"]!
                        .map((x) => ShopProductWholesalePrice.fromJson(x))),
        shopProductSerialNos: json["shop_product_serial_nos"] == null
            ? []
            : List<dynamic>.from(
                json["shop_product_serial_nos"]!.map((x) => x)),
        serialNo: json["serialNo"],
        newPrice: json["newPrice"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "product_unit_id": productUnitId,
        "product_id": productId,
        "category_id": categoryId,
        "cost_price": costPrice,
        "sell_price": sellPrice,
        "restock_alert": restockAlert,
        "attributes": attributes,
        "expired_date": expiredDate?.toIso8601String(),
        "stock_count": stockCount,
        "other_details": otherDetails,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
        "product_unit": productUnit?.toJson(),
        "shop_product_wholesale_prices": shopProductWholesalePrices == null
            ? []
            : List<dynamic>.from(
                shopProductWholesalePrices!.map((x) => x.toJson())),
        "shop_product_serial_nos": shopProductSerialNos == null
            ? []
            : List<dynamic>.from(shopProductSerialNos!.map((x) => x)),
        "serialNo": serialNo,
        "newPrice": newPrice,
        "qty": qty,
      };
}

class Product {
  int? id;
  String? name;
  String? slug;
  int? userId;
  int? brandId;
  String? barcode;
  int? type;
  String? photo;
  int? status;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? productCategoryId;
  Brand? productCategory;
  Brand? brand;

  Product({
    this.id,
    this.name,
    this.slug,
    this.userId,
    this.brandId,
    this.barcode,
    this.type,
    this.photo,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.productCategoryId,
    this.productCategory,
    this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        userId: json["user_id"],
        brandId: json["brand_id"],
        barcode: json["barcode"],
        type: json["type"],
        photo: json["photo"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        productCategoryId: json["product_category_id"],
        productCategory: json["product_category"] == null
            ? null
            : Brand.fromJson(json["product_category"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "user_id": userId,
        "brand_id": brandId,
        "barcode": barcode,
        "type": type,
        "photo": photo,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product_category_id": productCategoryId,
        "product_category": productCategory?.toJson(),
        "brand": brand?.toJson(),
      };
}

class Brand {
  int? id;
  String? name;
  String? slug;
  String? logo;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? photo;

  Brand({
    this.id,
    this.name,
    this.slug,
    this.logo,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.photo,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        logo: json["logo"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "logo": logo,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "photo": photo,
      };
}

class ProductUnit {
  int? id;
  dynamic productId;
  String? name;
  String? barcode;
  String? photo;
  String? slug;
  int? status;
  int? numOfUnits;
  dynamic isSmallestUnit;
  dynamic description;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductUnit({
    this.id,
    this.productId,
    this.name,
    this.barcode,
    this.photo,
    this.slug,
    this.status,
    this.numOfUnits,
    this.isSmallestUnit,
    this.description,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductUnit.fromJson(Map<String, dynamic> json) => ProductUnit(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        barcode: json["barcode"],
        photo: json["photo"],
        slug: json["slug"],
        status: json["status"],
        numOfUnits: json["num_of_units"],
        isSmallestUnit: json["is_smallest_unit"],
        description: json["description"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "barcode": barcode,
        "photo": photo,
        "slug": slug,
        "status": status,
        "num_of_units": numOfUnits,
        "is_smallest_unit": isSmallestUnit,
        "description": description,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ShopProductWholesalePrice {
  int? id;
  int? shopProductId;
  int? userId;
  int? price;
  int? wholesaleQuantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  int? costPrice;
  dynamic deletedAt;

  ShopProductWholesalePrice({
    this.id,
    this.shopProductId,
    this.userId,
    this.price,
    this.wholesaleQuantity,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.costPrice,
    this.deletedAt,
  });

  factory ShopProductWholesalePrice.fromJson(Map<String, dynamic> json) =>
      ShopProductWholesalePrice(
        id: json["id"],
        shopProductId: json["shop_product_id"],
        userId: json["user_id"],
        price: json["price"],
        wholesaleQuantity: json["wholesale_quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        costPrice: json["cost_price"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_product_id": shopProductId,
        "user_id": userId,
        "price": price,
        "wholesale_quantity": wholesaleQuantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "cost_price": costPrice,
        "deleted_at": deletedAt,
      };
}
