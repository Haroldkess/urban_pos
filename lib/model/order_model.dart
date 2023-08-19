// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());
 List<OrdersData> orderListFromJson(String str) =>
    List<OrdersData>.from(
        json.decode(str).map((x) => OrdersData.fromJson(x)));

class OrderModel {
    String? status;
    Data? data;

    OrderModel({
        this.status,
        this.data,
    });

    OrderModel copyWith({
        String? status,
        Data? data,
    }) => 
        OrderModel(
            status: status ?? this.status,
            data: data ?? this.data,
        );

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
    };
}

class Data {
    List<OrdersData>? data;
    String? path;
    int? perPage;
    String? nextPageUrl;
    dynamic prevPageUrl;

    Data({
        this.data,
        this.path,
        this.perPage,
        this.nextPageUrl,
        this.prevPageUrl,
    });

    Data copyWith({
        List<OrdersData>? data,
        String? path,
        int? perPage,
        String? nextPageUrl,
        dynamic prevPageUrl,
    }) => 
        Data(
            data: data ?? this.data,
            path: path ?? this.path,
            perPage: perPage ?? this.perPage,
            nextPageUrl: nextPageUrl ?? this.nextPageUrl,
            prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null ? [] : List<OrdersData>.from(json["data"]!.map((x) => OrdersData.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
    };
}

class OrdersData {
    int? id;
    String? orderNumber;
    int? userId;
    int? shopId;
    dynamic shopProductId;
    // dynamic shippingAddressId;
    // int? cartId;
    // int? itemCarton;
    // int? quantityItem;
    // int? shippingCost;
    //String? type;
    String? status;
  //  String? goodsStatus;
   // dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    double? amount;
   // int? useDelivery;
    dynamic createdBy;
    double? totalCostPrice;
    double? profit;
    double? amountToPay;
    double? amountPaid;
 //   int? remainingAmount;
    double? vatAmount;
    String? customerName;
    String? channel;
    List<Payment>? payments;
    User? user;
    Cart? cart;
 //   dynamic address;

    OrdersData({
        this.id,
        this.orderNumber,
        this.userId,
        this.shopId,
        this.shopProductId,
       // this.shippingAddressId,
       // this.cartId,
      //  this.itemCarton,
      //  this.quantityItem,
      //  this.shippingCost,
     //   this.type,
        this.status,
     //   this.goodsStatus,
       // this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.amount,
       // this.useDelivery,
        this.createdBy,
        this.totalCostPrice,
        this.profit,
        this.amountToPay,
        this.amountPaid,
       // this.remainingAmount,
        this.vatAmount,
        this.customerName,
        this.channel,
        this.payments,
        this.user,
        this.cart,
       // this.address,
    });

    OrdersData copyWith({
        int? id,
        String? orderNumber,
        int? userId,
        int? shopId,
        // dynamic shopProductId,
        // dynamic shippingAddressId,
        // int? cartId,
        // int? itemCarton,
        // int? quantityItem,
        // int? shippingCost,
        // String? type,
        String? status,
       // String? goodsStatus,
      //  dynamic deletedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        double? amount,
        int? useDelivery,
        dynamic createdBy,
        double? totalCostPrice,
        double? profit,
        double? amountToPay,
        double? amountPaid,
      //  int? remainingAmount,
        double? vatAmount,
        String? customerName,
        String? channel,
        List<Payment>? payments,
        User? user,
        Cart? cart,
     //   dynamic address,
    }) => 
        OrdersData(
            id: id ?? this.id,
            orderNumber: orderNumber ?? this.orderNumber,
            userId: userId ?? this.userId,
            shopId: shopId ?? this.shopId,
            shopProductId: shopProductId ?? this.shopProductId,
          //  shippingAddressId: shippingAddressId ?? this.shippingAddressId,
          //  cartId: cartId ?? this.cartId,
          //  itemCarton: itemCarton ?? this.itemCarton,
         //   quantityItem: quantityItem ?? this.quantityItem,
         //   shippingCost: shippingCost ?? this.shippingCost,
         //   type: type ?? this.type,
            status: status ?? this.status,
        //    goodsStatus: goodsStatus ?? this.goodsStatus,
           // deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            amount: amount ?? this.amount,
          //  useDelivery: useDelivery ?? this.useDelivery,
            createdBy: createdBy ?? this.createdBy,
            totalCostPrice: totalCostPrice ?? this.totalCostPrice,
            profit: profit ?? this.profit,
            amountToPay: amountToPay ?? this.amountToPay,
            amountPaid: amountPaid ?? this.amountPaid,
          //  remainingAmount: remainingAmount ?? this.remainingAmount,
            vatAmount: vatAmount ?? this.vatAmount,
            customerName: customerName ?? this.customerName,
            channel: channel ?? this.channel,
            payments: payments ?? this.payments,
            user: user ?? this.user,
            cart: cart ?? this.cart,
          //  address: address ?? this.address,
        );

    factory OrdersData.fromJson(Map<String, dynamic> json) => OrdersData(
        id: json["id"],//  null 
        orderNumber: json["order_number"],
        userId: json["user_id"],
        shopId: json["shop_id"],
     //   shopProductId: json["shop_product_id"], //  null 
    //    shippingAddressId: json["shipping_address_id"], //  null 
     //   cartId: json["cart_id"], //  null 
     //   itemCarton: json["item_carton"], //  null 
     //   quantityItem: json["quantity_item"], //  null 
    //    shippingCost: json["shipping_cost"], //  null 
     //   type: json["type"], //  null 
        status: json["status"], //  [paid , refund , cancelled , incomplete payment]
    //    goodsStatus: json["goods_status"], //  null 
     //   deletedAt: json["deleted_at"], //  null 
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        amount: json["amount"], // general amounnt of cart items
      //  useDelivery: json["use_delivery"], //  null 
        createdBy: json["created_by"], // user id of seller
        totalCostPrice: json["total_cost_price"],// total of all item costs price
        profit: json["profit"], // amount - total cost price
        amountToPay: json["amount_to_pay"]?.toDouble(), // amount + vat 
        amountPaid: json["amount_paid"]?.toDouble(),  // customer paid amount
     //   remainingAmount: json["remaining_amount"], // null
        vatAmount: json["vat_amount"]?.toDouble(), // from shop set
        customerName: json["customer_name"], // 
        channel: json["channel"], // mobile
        payments: json["payments"] == null ? [] : List<Payment>.from(json["payments"]!.map((x) => Payment.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        cart: json["cart"] == null ? null : Cart.fromJson(json["cart"]),
   //     address: json["address"], // null
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_number": orderNumber,
        "user_id": userId,
        "shop_id": shopId,
        "shop_product_id": shopProductId,
        // "shipping_address_id": shippingAddressId,
        // "cart_id": cartId,
        // "item_carton": itemCarton,
        // "quantity_item": quantityItem,
        // "shipping_cost": shippingCost,
        // "type": type,
        "status": status,
      //  "goods_status": goodsStatus,
       // "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "amount": amount,
      //  "use_delivery": useDelivery,
        "created_by": createdBy,
        "total_cost_price": totalCostPrice,
        "profit": profit,
        "amount_to_pay": amountToPay,
        "amount_paid": amountPaid,
       // "remaining_amount": remainingAmount,
        "vat_amount": vatAmount,
        "customer_name": customerName,
        "channel": channel,
        "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "cart": cart?.toJson(),
    //    "address": address,
    };
}

class Cart {
    int? id;
    int? userId;
    dynamic shopProductId;
    dynamic shopProductWholesaleId;
    dynamic shopProductTagId;
    int? shopId;
    int? quantity;
    int? quantityCartonItem;
    double? amount;
    int? status;
    String? isShopOwner;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic createdFor;
    String? customerName;
    List<CartItem>? cartItems;

    Cart({
        this.id,
        this.userId,
        this.shopProductId,
        this.shopProductWholesaleId,
        this.shopProductTagId,
        this.shopId,
        this.quantity,
        this.quantityCartonItem,
        this.amount,
        this.status,
        this.isShopOwner,
        this.createdAt,
        this.updatedAt,
        this.createdFor,
        this.customerName,
        this.cartItems,
    });

    Cart copyWith({
        int? id,
        int? userId,
        dynamic shopProductId,
        dynamic shopProductWholesaleId,
        dynamic shopProductTagId,
        int? shopId,
        int? quantity,
        int? quantityCartonItem,
        double? amount,
        int? status,
        String? isShopOwner,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic createdFor,
        String? customerName,
        List<CartItem>? cartItems,
    }) => 
        Cart(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            shopProductId: shopProductId ?? this.shopProductId,
            shopProductWholesaleId: shopProductWholesaleId ?? this.shopProductWholesaleId,
            shopProductTagId: shopProductTagId ?? this.shopProductTagId,
            shopId: shopId ?? this.shopId,
            quantity: quantity ?? this.quantity,
            quantityCartonItem: quantityCartonItem ?? this.quantityCartonItem,
            amount: amount ?? this.amount,
            status: status ?? this.status,
            isShopOwner: isShopOwner ?? this.isShopOwner,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            createdFor: createdFor ?? this.createdFor,
            customerName: customerName ?? this.customerName,
            cartItems: cartItems ?? this.cartItems,
        );

    factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"], // anything
        userId: json["user_id"], // id sellwe
      //  shopProductId: json["shop_product_id"], //null
      //  shopProductWholesaleId: json["shop_product_wholesale_id"], //null
      //  shopProductTagId: json["shop_product_tag_id"], //null
        shopId: json["shop_id"], // shopid
        quantity: json["quantity"], // rtot qty
      //  quantityCartonItem: json["quantity_carton_item"], //null
        amount: json["amount"], // tot amount in cart
        status: json["status"], // 1
        isShopOwner: json["is_shop_owner"], // true
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      //  createdFor: json["created_for"], // null
        customerName: json["customer_name"],  // customer name
        cartItems: json["cart_items"] == null ? [] : List<CartItem>.from(json["cart_items"]!.map((x) => CartItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
      //  "shop_product_id": shopProductId,
      //  "shop_product_wholesale_id": shopProductWholesaleId,
     //   "shop_product_tag_id": shopProductTagId,
        "shop_id": shopId,
        "quantity": quantity,
     //   "quantity_carton_item": quantityCartonItem,
        "amount": amount,
        "status": status,
        "is_shop_owner": isShopOwner,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
     //   "created_for": createdFor,
        "customer_name": customerName,
        "cart_items": cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
    };
}

class CartItem {
    int? id;
    int? cartId;
    int? shopProductId;
    dynamic price;
   dynamic discount;
    int? quantity;
    String? status;
    String? content;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic costPrice;
    ShopProduct? shopProduct;

    CartItem({
        this.id,
        this.cartId,
        this.shopProductId,
        this.price,
        this.discount,
        this.quantity,
        this.status,
        this.content,
        this.createdAt,
        this.updatedAt,
        this.costPrice,
        this.shopProduct,
    });

    CartItem copyWith({
        int? id,
        int? cartId,
        int? shopProductId,
        int? price,
        dynamic discount,
        int? quantity,
        String? status,
        String? content,
        DateTime? createdAt,
        DateTime? updatedAt,
        dynamic costPrice,
        ShopProduct? shopProduct,
    }) => 
        CartItem(
            id: id ?? this.id,
            cartId: cartId ?? this.cartId,
            shopProductId: shopProductId ?? this.shopProductId,
            price: price ?? this.price,
            discount: discount ?? this.discount,
            quantity: quantity ?? this.quantity,
            status: status ?? this.status,
            content: content ?? this.content,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            costPrice: costPrice ?? this.costPrice,
            shopProduct: shopProduct ?? this.shopProduct,
        );

    factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["id"], // null
        cartId: json["cart_id"], // null
        shopProductId: json["shop_product_id"], // shop prod id
        price: json["price"], // sell price 
        discount: json["discount"], // null
        quantity: json["quantity"], // qty
        status: json["status"], // true
        content: json["content"], // note
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        costPrice: json["cost_price"], // cost p
        shopProduct: json["shop_product"] == null ? null : ShopProduct.fromJson(json["shop_product"]),  //null
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cart_id": cartId,
        "shop_product_id": shopProductId,
        "price": price,
        "discount": discount,
        "quantity": quantity,
        "status": status,
        "content": content,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "cost_price": costPrice,
        "shop_product": shopProduct?.toJson(),
    };
}

class ShopProduct {
    int? id;
    int? shopId;
    int? productUnitId;
    int? productId;
    int? categoryId;
    int? costPrice;
    int? sellPrice;
    int? restockAlert;
    int? attributes;
    DateTime? expiredDate;
    int? stockCount;
    String? otherDetails;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    OrderProduct? product;
    ProductUnit? productUnit;

    ShopProduct({
        this.id,
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
    });

    ShopProduct copyWith({
        int? id,
        int? shopId,
        int? productUnitId,
        int? productId,
        int? categoryId,
        int? costPrice,
        int? sellPrice,
        int? restockAlert,
        int? attributes,
        DateTime? expiredDate,
        int? stockCount,
        String? otherDetails,
        dynamic deletedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        OrderProduct? product,
        ProductUnit? productUnit,
    }) => 
        ShopProduct(
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
        );

    factory ShopProduct.fromJson(Map<String, dynamic> json) => ShopProduct(
        id: json["id"],
        shopId: json["shop_id"],
        productUnitId: json["product_unit_id"],
        productId: json["product_id"],
        categoryId: json["category_id"],
        costPrice: json["cost_price"],
        sellPrice: json["sell_price"],
        restockAlert: json["restock_alert"],
        attributes: json["attributes"],
        expiredDate: json["expired_date"] == null ? null : DateTime.parse(json["expired_date"]),
        stockCount: json["stock_count"],
        otherDetails: json["other_details"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : OrderProduct.fromJson(json["product"]),
        productUnit: json["product_unit"] == null ? null : ProductUnit.fromJson(json["product_unit"]),
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
    };
}

class OrderProduct {
    int? id;
    String? name;
    String? slug;
    int? userId;
    int? brandId;
    dynamic barcode;
    int? type;
    dynamic photo;
    int? status;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? productCategoryId;

    OrderProduct({
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
    });

    OrderProduct copyWith({
        int? id,
        String? name,
        String? slug,
        int? userId,
        int? brandId,
        dynamic barcode,
        int? type,
        dynamic photo,
        int? status,
        dynamic deletedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? productCategoryId,
    }) => 
        OrderProduct(
            id: id ?? this.id,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            userId: userId ?? this.userId,
            brandId: brandId ?? this.brandId,
            barcode: barcode ?? this.barcode,
            type: type ?? this.type,
            photo: photo ?? this.photo,
            status: status ?? this.status,
            deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            productCategoryId: productCategoryId ?? this.productCategoryId,
        );

    factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        productCategoryId: json["product_category_id"],
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
    };
}

class ProductUnit {
    int? id;
    int? productId;
    String? name;
    dynamic barcode;
    dynamic photo;
    String? slug;
    int? status;
    int? numOfUnits;
    int? isSmallestUnit;
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

    ProductUnit copyWith({
        int? id,
        int? productId,
        String? name,
        dynamic barcode,
        dynamic photo,
        String? slug,
        int? status,
        int? numOfUnits,
        int? isSmallestUnit,
        dynamic description,
        dynamic deletedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ProductUnit(
            id: id ?? this.id,
            productId: productId ?? this.productId,
            name: name ?? this.name,
            barcode: barcode ?? this.barcode,
            photo: photo ?? this.photo,
            slug: slug ?? this.slug,
            status: status ?? this.status,
            numOfUnits: numOfUnits ?? this.numOfUnits,
            isSmallestUnit: isSmallestUnit ?? this.isSmallestUnit,
            description: description ?? this.description,
            deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ProductUnit.fromJson(Map<String, dynamic> json) => ProductUnit(
        id: json["id"],
        productId: json["product_id"],
        name:json["name"],
        barcode: json["barcode"],
        photo: json["photo"],
        slug: json["slug"],
        status: json["status"],
        numOfUnits: json["num_of_units"],
        isSmallestUnit: json["is_smallest_unit"],
        description: json["description"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

class Payment {
    int? id;
    int? userId;
    String? orderNumberTrack; // order numb
    int? amountToPay;
    int? amountPaid; 
    int? remainingAmount;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? paymentType;
    int? isConfirmed;
    double? amount;

    Payment({
        this.id,
        this.userId,
        this.orderNumberTrack,
        this.amountToPay,
        this.amountPaid,
        this.remainingAmount,
        this.createdAt,
        this.updatedAt,
        this.paymentType,
        this.isConfirmed,
        this.amount,
    });

    Payment copyWith({
        int? id,
        int? userId,
        String? orderNumberTrack,
        int? amountToPay,
        int? amountPaid,
        int? remainingAmount,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? paymentType,
        int? isConfirmed,
        double? amount,
    }) => 
        Payment(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            orderNumberTrack: orderNumberTrack ?? this.orderNumberTrack,
            amountToPay: amountToPay ?? this.amountToPay,
            amountPaid: amountPaid ?? this.amountPaid,
            remainingAmount: remainingAmount ?? this.remainingAmount,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            paymentType: paymentType ?? this.paymentType,
            isConfirmed: isConfirmed ?? this.isConfirmed,
            amount: amount ?? this.amount,
        );

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        userId: json["user_id"],
        orderNumberTrack: json["order_number_track"],
        amountToPay: json["amount_to_pay"], // null
        amountPaid: json["amount_paid"], // null
        remainingAmount: json["remaining_amount"], //null
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        paymentType: json["payment_type"],
        isConfirmed: json["is_confirmed"],
        amount: json["amount"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_number_track": orderNumberTrack,
        "amount_to_pay": amountToPay,
        "amount_paid": amountPaid,
        "remaining_amount": remainingAmount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "payment_type": paymentType,
        "is_confirmed": isConfirmed,
        "amount": amount,
    };
}

class User {
    int? id;
    String? surname;
    String? firstName;
    dynamic otherName;
    String? username;
    String? email;
    String? gender;
    String? contactNo;
    String? language;
    DateTime? expiry;
    dynamic emailVerifiedAt;
    DateTime? phoneVerifiedAt;
    String? image;
    DateTime? lastLoginAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
        this.id,
        this.surname,
        this.firstName,
        this.otherName,
        this.username,
        this.email,
        this.gender,
        this.contactNo,
        this.language,
        this.expiry,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.image,
        this.lastLoginAt,
        this.createdAt,
        this.updatedAt,
    });

    User copyWith({
        int? id,
        String? surname,
        String? firstName,
        dynamic otherName,
        String? username,
        String? email,
        String? gender,
        String? contactNo,
        String? language,
        DateTime? expiry,
        dynamic emailVerifiedAt,
        DateTime? phoneVerifiedAt,
        String? image,
        DateTime? lastLoginAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        User(
            id: id ?? this.id,
            surname: surname ?? this.surname,
            firstName: firstName ?? this.firstName,
            otherName: otherName ?? this.otherName,
            username: username ?? this.username,
            email: email ?? this.email,
            gender: gender ?? this.gender,
            contactNo: contactNo ?? this.contactNo,
            language: language ?? this.language,
            expiry: expiry ?? this.expiry,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            phoneVerifiedAt: phoneVerifiedAt ?? this.phoneVerifiedAt,
            image: image ?? this.image,
            lastLoginAt: lastLoginAt ?? this.lastLoginAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        surname: json["surname"],
        firstName: json["first_name"],
        otherName: json["other_name"],
        username: json["username"],
        email:json["email"],
        gender: json["gender"],
        contactNo: json["contact_no"],
        language: json["language"],
        expiry: json["expiry"] == null ? null : DateTime.parse(json["expiry"]),
        emailVerifiedAt: json["email_verified_at"],
        phoneVerifiedAt: json["phone_verified_at"] == null ? null : DateTime.parse(json["phone_verified_at"]),
        image: json["image"],
        lastLoginAt: json["last_login_at"] == null ? null : DateTime.parse(json["last_login_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "surname": surname,
        "first_name": firstName,
        "other_name": otherName,
        "username": username,
        "email": email,
        "gender": gender,
        "contact_no": contactNo,
        "language": language,
        "expiry": expiry?.toIso8601String(),
        "email_verified_at": emailVerifiedAt,
        "phone_verified_at": phoneVerifiedAt?.toIso8601String(),
        "image": image,
        "last_login_at": lastLoginAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

