class Package {
  final String id;
  final String name;
  final String description;
  final String image;
  final String location;

  const Package(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.location});

  Package.fromJson(Map<String, dynamic> json)
      : id = json["idProducto"],
        name = json["nombre"],
        description = json["descripcion"],
        image = json["imagen"],
        location = json["ubicacin"];

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "description": description, "image": image};
  }
}

class FavoritePackage {
  final String id;
  final String name;
  final String description;
  final String image;

  const FavoritePackage(
      {required this.id,
      required this.name,
      required this.description,
      required this.image});

  FavoritePackage.fromMap(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        image = json["image"];

  FavoritePackage.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        description = json["description"],
        image = json["image"];
}
