class Merchantdata {
  int id;
  String uname;
  String pword;
  String full_shop_name;
  String alias;
  String priv_key;
  String shop_pos;
  String contact_num;
  String contact_detail;
  String address;
  String status;
  String level;
  String timestamp;

  Merchantdata(
      {this.id,
      this.uname,
      this.pword,
      this.full_shop_name,
      this.alias,
      this.priv_key,
      this.shop_pos,
      this.contact_num,
      this.contact_detail,
      this.address,
      this.status,
      this.level,
      this.timestamp});

  factory Merchantdata.fromJson(Map<String, dynamic> json) {
    return Merchantdata(
      id: json['id'],
      uname: json['uname'],
      pword: json['pword'],
      full_shop_name: json['full_shop_name'],
      alias: json['alias'],
      priv_key: json['priv_key'],
      shop_pos: json['shop_pos'],
      contact_num: json['contact_num'],
      contact_detail: json['contact_detail'],
      address: json['address'],
      status: json['status'],
      level: json['level'],
      timestamp: json['timestamp'],
    );
  }
}

//class Shop_pos {
//  int lat;
//  int long;
//
//  Shop_pos({this.lat, this.long});
//
//  factory Shop_pos.fromJson(Map<String, dynamic> json) {
//    return Shop_pos(lat: json['lat'], long: json['long']);
//  }
//}
