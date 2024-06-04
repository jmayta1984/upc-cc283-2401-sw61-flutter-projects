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
}
