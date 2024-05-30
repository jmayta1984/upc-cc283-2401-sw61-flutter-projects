class PowerStats {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  const PowerStats(
      {required this.intelligence,
      required this.strength,
      required this.speed,
      required this.durability,
      required this.power,
      required this.combat});

  PowerStats.fromJson(Map<String, dynamic> json)
      : intelligence = json["intelligence"] ?? "0",
        strength = json["strength"] ?? "0",
        speed = json["speed"] ?? "0",
        durability = json["durability"] ?? "0",
        power = json["power"] ?? "0",
        combat = json["combat"] ?? "0";
}

class SuperHero {
  final String id;
  final String name;
  final String fullName;
  final String image;
  final PowerStats stats;

  const SuperHero(
      {required this.id,
      required this.name,
      required this.fullName,
      required this.image,
      required this.stats});

  SuperHero.fromJson(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        fullName = map["biography"]["full-name"],
        image = map["image"]["url"],
        stats = PowerStats.fromJson(map["powerstats"]);

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "full_name": fullName, "image": image};
  }
}
