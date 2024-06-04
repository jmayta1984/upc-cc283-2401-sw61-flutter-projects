import 'package:flutter/material.dart';
import 'package:turismo_app/models/package.dart';
import 'package:turismo_app/services/package_service.dart';

enum Place {
  machuPicchu(siteId: "s001", description: "Machu Picchu"),
  ayacucho(siteId: "s002", description: "Ayachucho"),
  chichenItza(siteId: "s003", description: "Chichen Itza"),
  cristoRedentor(siteId: "s004", description: "Cristo Redentor"),
  islasMalvinas(siteId: "s005", description: "Islas Malvinas"),
  murallaChina(siteId: "s006", description: "Muralla China");

  final String siteId;
  final String description;
  const Place({required this.siteId, required this.description});
}

class PackageSearchScreen extends StatefulWidget {
  const PackageSearchScreen({super.key});

  @override
  State<PackageSearchScreen> createState() => _PackageSearchScreenState();
}

class _PackageSearchScreenState extends State<PackageSearchScreen> {
  final PackageService _packageService = PackageService();
  final TextEditingController _controllerPlace = TextEditingController();
  final TextEditingController _controllerType = TextEditingController();
  List<Package> _packages = [];

  search() async {
    _packages = await _packageService.filterByPlaceByType(
        _controllerPlace.text, _controllerType.text);
    if (mounted) {
      setState(() {
        _packages = _packages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: Place.values
                  .map((e) => GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.description),
                        ),
                      ))
                  .toList(),
            ),
          ),
          TextField(
            controller: _controllerPlace,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
          TextField(
            controller: _controllerType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
          OutlinedButton(onPressed: search, child: const Text("Search")),
          Expanded(child: PackageList(packages: _packages)),
        ],
      ),
    );
  }
}

class PackageList extends StatelessWidget {
  const PackageList({super.key, required this.packages});
  final List<Package> packages;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        Package package = packages[index];

        return Card(
          child: Column(
            children: [
              Text(package.name),
              Text(package.location),
              Text(package.description),
              Image.network(
                width: width,
                package.image,
                fit: BoxFit.scaleDown,
              )
            ],
          ),
        );
      },
    );
  }
}
