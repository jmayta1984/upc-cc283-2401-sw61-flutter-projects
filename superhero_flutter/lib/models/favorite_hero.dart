class FavoriteHero {
  String id;
  String name;
  String fullName;
  String path;

  FavoriteHero(
      {required this.id,
      required this.name,
      required this.fullName,
      required this.path});

  FavoriteHero.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        fullName = map["full_name"],
        path = map["image"];
}
