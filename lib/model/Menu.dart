

class Menu{
  final String name;
  final String alias;
  final String level;
  final String description;
  final String url;
  final String heroBox;
  Menu({this.name,this.alias,this.level,this.description,this.heroBox,this.url});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      name: json['name'],
      alias: json['alias'],
      level: json['level'],
      description: json['description'],
      url: json['url'],
      heroBox: json['heroBox'],
    );
  }

}
