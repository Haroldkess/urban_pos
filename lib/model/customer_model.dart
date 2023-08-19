// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  String? status;
  Data? data;
  bool? success;
  String? message;

  CustomerModel({
    this.status,
    this.data,
    this.success,
    this.message,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
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
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  int? userId;
  int? shopId;
  String? name;
  String? phone;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? type;
  User? user;
  Shop? shop;

  Datum({
    this.id,
    this.userId,
    this.shopId,
    this.name,
    this.phone,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.user,
    this.shop,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        shopId: json["shop_id"],
        name: json["name"],
        phone: json["phone"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        type: json["type"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
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
        "user": user?.toJson(),
        "shop": shop?.toJson(),
      };
}

class Shop {
  dynamic id;
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
