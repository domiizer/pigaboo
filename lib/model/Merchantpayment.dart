class Merchantpayment {
  int id;
  String shopAlias;
  String method;
  String accDetail;
  String accNumber;
  String accName;
  String accBank;
  String qrUrl;
  DateTime timestamp;

  Merchantpayment({
    this.id,
    this.shopAlias,
    this.method,
    this.accDetail,
    this.accNumber,
    this.accName,
    this.accBank,
    this.qrUrl,
    this.timestamp,
  });

  factory Merchantpayment.fromJson(Map<String, dynamic> json) =>
      Merchantpayment(
        id: json["id"],
        shopAlias: json["shop_alias"],
        method: json["method"],
        accDetail: json["acc_detail"],
        accNumber: json["acc_number"],
        accName: json["acc_name"],
        accBank: json["acc_bank"],
        qrUrl: json["qr_url"],
        timestamp: DateTime.parse(json["timestamp"]),
      );
}