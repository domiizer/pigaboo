class Merchanttheme {
  int id;
  String shopAlias;
  String mainColour;
  String secColour;
  String txtColour;
  String logoUrl;
  String heroboxUrl;
  String promoUrl;
  String shopDescript;

  Merchanttheme({
    this.id,
    this.shopAlias,
    this.mainColour='C0C0C0',
    this.secColour,
    this.txtColour,
    this.logoUrl,
    this.heroboxUrl,
    this.promoUrl,
    this.shopDescript,
  });

  factory Merchanttheme.fromJson(Map<String, dynamic> json) =>
      Merchanttheme(
        id: json["id"],
        shopAlias: json["shop_alias"],
        mainColour: json["main_colour"],
        secColour: json["sec_colour"],
        txtColour: json["txt_colour"],
        logoUrl: json["logo_url"],
        heroboxUrl: json["herobox_url"],
        promoUrl: json["promo_url"],
        shopDescript: json["shop_descript"],
      );
}