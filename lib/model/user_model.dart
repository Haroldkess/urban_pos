// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  String? status;
  ShopData? data;
  bool? success;
  String? message;

  ShopModel({
    this.status,
    this.data,
    this.success,
    this.message,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        status: json["status"],
        data: json["data"] == null ? null : ShopData.fromJson(json["data"]),
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

class ShopData {
  String? token;
  Shop? shop;
  ShopUser? user;

  ShopData({
    this.token,
    this.shop,
    this.user,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) => ShopData(
        token: json["token"],
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        user: json["user"] == null ? null : ShopUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "shop": shop?.toJson(),
        "user": user?.toJson(),
      };
}

class Shop {
  int? id;
  dynamic ownerId;
  dynamic categoryId;
  String? shopId;
  String? logo;
  String? qrCode;
  String? name;
  String? whatsAppNumber;
  dynamic addressId;
  dynamic cityId;
  dynamic stateId;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic email;
  dynamic address;

  Shop({
    this.id,
    this.ownerId,
    this.categoryId,
    this.shopId,
    this.logo,
    this.qrCode,
    this.name,
    this.whatsAppNumber,
    this.addressId,
    this.cityId,
    this.stateId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.email,
    this.address,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        ownerId: json["owner_id"],
        categoryId: json["category_id"],
        shopId: json["shop_id"],
        logo: json["logo"],
        qrCode: json["qr_code"],
        name: json["name"],
        whatsAppNumber: json["whats_app_number"],
        addressId: json["address_id"],
        cityId: json["city_id"],
        stateId: json["state_id"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "category_id": categoryId,
        "shop_id": shopId,
        "logo": logo,
        "qr_code": qrCode,
        "name": name,
        "whats_app_number": whatsAppNumber,
        "address_id": addressId,
        "city_id": cityId,
        "state_id": stateId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "email": email,
        "address": address,
      };
}

class ShopUser {
  int? id;
  String? surname;
  String? firstName;
  dynamic otherName;
  dynamic username;
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
  List<Role>? roles;

  ShopUser({
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
    this.roles,
  });

  factory ShopUser.fromJson(Map<String, dynamic> json) => ShopUser(
        id: json["id"],
        surname: json["surname"],
        firstName: json["first_name"],
        otherName: json["other_name"],
        username: json["username"],
        email: json["email"],
        gender: json["gender"],
        contactNo: json["contact_no"],
        language: json["language"],
        expiry: json["expiry"] == null ? null : DateTime.parse(json["expiry"]),
        emailVerifiedAt: json["email_verified_at"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : DateTime.parse(json["phone_verified_at"]),
        image: json["image"],
        lastLoginAt: json["last_login_at"] == null
            ? null
            : DateTime.parse(json["last_login_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
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
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  dynamic id;
  String? name;
  String? guardName;
  dynamic isShopRole;
  DateTime? createdAt;
  DateTime? updatedAt;
  Pivot? pivot;

  Role({
    this.id,
    this.name,
    this.guardName,
    this.isShopRole,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: json["guard_name"],
        isShopRole: json["is_shop_role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardName,
        "is_shop_role": isShopRole,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  dynamic modelId;
  dynamic roleId;
  String? modelType;

  Pivot({
    this.modelId,
    this.roleId,
    this.modelType,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
      };
}
