// To parse this JSON data, do
//
//     final merchantItem = merchantItemFromJson(jsonString);

import 'dart:convert';

MerchantItem merchantItemFromJson(String str) => MerchantItem.fromJson(json.decode(str));

String merchantItemToJson(MerchantItem data) => json.encode(data.toJson());

class MerchantItem {
  bool status;
  List<Detail> detail;

  MerchantItem({
    this.status,
    this.detail,
  });

  factory MerchantItem.fromJson(Map<String, dynamic> json) => MerchantItem(
    status: json["status"],
    detail: List<Detail>.from(json["detail"].map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "detail": List<dynamic>.from(detail.map((x) => x.toJson())),
  };
}

class Detail {
  int id;
  ShopCode shopCode;
  String menuName;
  String menuId;
  String description;
  int price;
  String isAvailable;
  String categoryType;
  int orderCount;
  String isPromoted;
  Addon addon;
  String imgUrl;
  DateTime timestamp;

  Detail({
    this.id,
    this.shopCode,
    this.menuName,
    this.menuId,
    this.description,
    this.price,
    this.isAvailable,
    this.categoryType,
    this.orderCount,
    this.isPromoted,
    this.addon,
    this.imgUrl,
    this.timestamp,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    shopCode: shopCodeValues.map[json["shop_code"]],
    menuName: json["menu_name"],
    menuId: json["menu_id"],
    description: json["description"],
    price: json["price"],
    isAvailable: json["isAvailable"],
    categoryType: json["category_type"],
    orderCount: json["order_count"],
    isPromoted: json["isPromoted"],
    addon: addonValues.map[json["addon"]],
    imgUrl: json["img_url"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_code": shopCodeValues.reverse[shopCode],
    "menu_name": menuName,
    "menu_id": menuId,
    "description": description,
    "price": price,
    "isAvailable": isAvailable,
    "category_type": categoryType,
    "order_count": orderCount,
    "isPromoted": isPromoted,
    "addon": addonValues.reverse[addon],
    "img_url": imgUrl,
    "timestamp": timestamp.toIso8601String(),
  };
}

enum Addon { NO_ADDON }

final addonValues = EnumValues({
  "NO_ADDON": Addon.NO_ADDON
});

enum ShopCode { BUIZ }

final shopCodeValues = EnumValues({
  "BUIZ": ShopCode.BUIZ
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
