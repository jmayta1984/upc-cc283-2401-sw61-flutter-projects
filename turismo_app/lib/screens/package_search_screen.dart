import 'package:flutter/material.dart';
import 'package:turismo_app/dao/package_dao.dart';
import 'package:turismo_app/models/package.dart';
import 'package:turismo_app/services/package_service.dart';

enum Place {
  machuPicchu(id: "s001", description: "Machu Picchu"),
  ayacucho(id: "s002", description: "Ayacucho"),
  chichenItza(id: "s003", description: "Chichen Itza"),
  cristoRedentor(id: "s004", description: "Cristo Redentor"),
  islasMalvinas(id: "s005", description: "Islas Malvinas"),
  murallaChina(id: "s006", description: "Muralla China");

  final String id;
  final String description;
  const Place({required this.id, required this.description});
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
    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        Package package = packages[index];

        return PackageItem(package: package);
      },
    );
  }
}

class PackageItem extends StatefulWidget {
  const PackageItem({
    super.key,
    required this.package,
  });

  final Package package;

  @override
  State<PackageItem> createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  bool _isFavorite = false;

  initialize() async {
    _isFavorite = await PackageDao().isFavorite(widget.package);

    if (mounted) {
      setState(() {
        _isFavorite = _isFavorite;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    initialize();

    return Card(
      child: Column(
        children: [
          Text(widget.package.name),
          Text(widget.package.location),
          IconButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _isFavorite = !_isFavorite;
                    _isFavorite
                        ? PackageDao().insert(widget.package)
                        : PackageDao().delete(widget.package);
                  });
                }
              },
              icon: Icon(Icons.favorite,
                  color: _isFavorite
                      ? Theme.of(context).primaryColorDark
                      : Theme.of(context).hintColor)),
          Text(widget.package.description),
          Image.network(
            widget.package.image,
            height: width * 0.75,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
