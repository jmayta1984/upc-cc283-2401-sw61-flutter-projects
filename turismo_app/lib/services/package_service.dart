import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:turismo_app/models/package.dart';

class PackageService {
  final String baseUrl =
      "https://dev.formandocodigo.com/ServicioTour/productossitiotipo.php";

  Future<List<Package>> filterByPlaceByType(String place, String type) async {
    http.Response response =
        await http.get(Uri.parse("$baseUrl?sitio=$place&tipo=$type"));
    if (response.statusCode == HttpStatus.ok) {
      List maps = json.decode(response.body);
      return maps.map((map) => Package.fromJson(map)).toList();
    }
    return [];
  }
}
