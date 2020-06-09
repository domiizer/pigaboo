// To parse this JSON data, do
//
//     final merchantAllMenuList = merchantAllMenuListFromJson(jsonString);

class MerchantAllMenuList {
  int id;
  String shopCode;
  String menuName;
  String menuId;
  String description;
  int price;
  String isAvailable;
  String categoryType;
  int orderCount;
  String isPromoted;
  String addon;
  String imgUrl;
  String timestamp;

  MerchantAllMenuList({
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

  factory MerchantAllMenuList.fromJson(Map<String, dynamic> json) {
    return MerchantAllMenuList(
      id: json["id"],
      shopCode: json["shop_code"],
      menuName: json["menu_name"],
      menuId: json["menu_id"],
      description: json["description"],
      price: json["price"],
      isAvailable: json["isAvailable"],
      categoryType: json["category_type"],
      orderCount: json["order_count"],
      isPromoted: json["isPromoted"],
      addon: json["addon"],
      imgUrl: json["img_url"],
      timestamp: json["timestamp"],
    );
  }
}
