// To parse this JSON data, do
//
//     final shopSettingsModel = shopSettingsModelFromJson(jsonString);

import 'dart:convert';

ShopSettingsModel shopSettingsModelFromJson(String str) => ShopSettingsModel.fromJson(json.decode(str));

String shopSettingsModelToJson(ShopSettingsModel data) => json.encode(data.toJson());

class ShopSettingsModel {
    String? status;
    Data? data;
    bool? success;
    String? message;

    ShopSettingsModel({
        this.status,
        this.data,
        this.success,
        this.message,
    });

    ShopSettingsModel copyWith({
        String? status,
        Data? data,
        bool? success,
        String? message,
    }) => 
        ShopSettingsModel(
            status: status ?? this.status,
            data: data ?? this.data,
            success: success ?? this.success,
            message: message ?? this.message,
        );

    factory ShopSettingsModel.fromJson(Map<String, dynamic> json) => ShopSettingsModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "success": success,
        "message": message,
    };
}

class Data {
    List<ShopCustomer>? shopCustomers;
    List<ShopSetting>? shopSettings;
    List<ShopService>? shopServices;

    Data({
        this.shopCustomers,
        this.shopSettings,
        this.shopServices,
    });

    Data copyWith({
        List<ShopCustomer>? shopCustomers,
        List<ShopSetting>? shopSettings,
        List<ShopService>? shopServices,
    }) => 
        Data(
            shopCustomers: shopCustomers ?? this.shopCustomers,
            shopSettings: shopSettings ?? this.shopSettings,
            shopServices: shopServices ?? this.shopServices,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        shopCustomers: json["shop_customers"] == null ? [] : List<ShopCustomer>.from(json["shop_customers"]!.map((x) => ShopCustomer.fromJson(x))),
        shopSettings: json["shop_settings"] == null ? [] : List<ShopSetting>.from(json["shop_settings"]!.map((x) => ShopSetting.fromJson(x))),
        shopServices: json["shop_services"] == null ? [] : List<ShopService>.from(json["shop_services"]!.map((x) => ShopService.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "shop_customers": shopCustomers == null ? [] : List<dynamic>.from(shopCustomers!.map((x) => x.toJson())),
        "shop_settings": shopSettings == null ? [] : List<dynamic>.from(shopSettings!.map((x) => x.toJson())),
        "shop_services": shopServices == null ? [] : List<dynamic>.from(shopServices!.map((x) => x.toJson())),
    };
}

class ShopCustomer {
    int? id;
    int? userId;
    int? shopId;
    String? name;
    String? phone;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? type;

    ShopCustomer({
        this.id,
        this.userId,
        this.shopId,
        this.name,
        this.phone,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.type,
    });

    ShopCustomer copyWith({
        int? id,
        int? userId,
        int? shopId,
        String? name,
        String? phone,
        dynamic deletedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? type,
    }) => 
        ShopCustomer(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            shopId: shopId ?? this.shopId,
            name: name ?? this.name,
            phone: phone ?? this.phone,
            deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            type: type ?? this.type,
        );

    factory ShopCustomer.fromJson(Map<String, dynamic> json) => ShopCustomer(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        name: json["name"],
        phone: json["phone"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shop_id": shopId,
        "name": name,
        "phone": phone,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "type": type,
    };
}

class ShopService {
    int? id;
    int? shopId;
    String? name;
    String? slug;
   dynamic costPrice;
   dynamic sellPrice;
    String? description;
    String? tags;
    dynamic deletedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    ShopService({
        this.id,
        this.shopId,
        this.name,
        this.slug,
        this.costPrice,
        this.sellPrice,
        this.description,
        this.tags,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    ShopService copyWith({
        int? id,
        int? shopId,
        String? name,
        String? slug,
        dynamic costPrice,
        dynamic sellPrice,
        String? description,
        String? tags,
        dynamic deletedAt,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ShopService(
            id: id ?? this.id,
            shopId: shopId ?? this.shopId,
            name: name ?? this.name,
            slug: slug ?? this.slug,
            costPrice: costPrice ?? this.costPrice,
            sellPrice: sellPrice ?? this.sellPrice,
            description: description ?? this.description,
            tags: tags ?? this.tags,
            deletedAt: deletedAt ?? this.deletedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ShopService.fromJson(Map<String, dynamic> json) => ShopService(
        id: json["id"],
        shopId: json["shop_id"],
        name: json["name"],
        slug: json["slug"],
        costPrice: json["cost_price"],
        sellPrice: json["sell_price"],
        description: json["description"],
        tags: json["tags"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "name": name,
        "slug": slug,
        "cost_price": costPrice,
        "sell_price": sellPrice,
        "description": description,
        "tags": tags,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class ShopSetting {
    int? id;
    int? shopId;
    String? key;
    String? value;
    String? displayName;
    dynamic type;
    DateTime? createdAt;
    DateTime? updatedAt;

    ShopSetting({
        this.id,
        this.shopId,
        this.key,
        this.value,
        this.displayName,
        this.type,
        this.createdAt,
        this.updatedAt,
    });

    ShopSetting copyWith({
        int? id,
        int? shopId,
        String? key,
        String? value,
        String? displayName,
        dynamic type,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ShopSetting(
            id: id ?? this.id,
            shopId: shopId ?? this.shopId,
            key: key ?? this.key,
            value: value ?? this.value,
            displayName: displayName ?? this.displayName,
            type: type ?? this.type,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ShopSetting.fromJson(Map<String, dynamic> json) => ShopSetting(
        id: json["id"],
        shopId: json["shop_id"],
        key: json["key"],
        value: json["value"],
        displayName: json["display_name"],
        type: json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "key": key,
        "value": value,
        "display_name": displayName,
        "type": type,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
