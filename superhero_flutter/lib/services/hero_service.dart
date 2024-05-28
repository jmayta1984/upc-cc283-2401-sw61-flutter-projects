import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:superhero_flutter/models/hero.dart';

class HeroService {
  final String baseUrl =
      "https://www.superheroapi.com/api.php/10157703717092094/search/";

  Future<List> searchHeros(String name) async {
    http.Response response = await http.get(Uri.parse("$baseUrl$name"));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(response.body);
      List maps = jsonResponse["results"];
      return maps.map((map) => SuperHero.fromJson(map)).toList();
    }
    return [];
  }
}
