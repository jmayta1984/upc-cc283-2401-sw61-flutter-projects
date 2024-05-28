class SuperHero {
  final String id;
  final String name;
  final String fullName;
  final String image;

  const SuperHero({
    required this.id,
    required this.name,
    required this.fullName,
    required this.image,
  });

  SuperHero.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        fullName = map["biography"]["full-name"],
        image = map["image"]["url"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "full_name": fullName,
      "image": image
    };
  }
}
