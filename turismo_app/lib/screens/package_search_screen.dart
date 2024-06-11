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

enum Type {
  viaje(id: "1", description: "Viaje"),
  hospedaje(id: "2", description: "Hospedaje");

  final String id;
  final String description;
  const Type({required this.id, required this.description});
}

class PackageSearchScreen extends StatefulWidget {
  const PackageSearchScreen({super.key});

  @override
  State<PackageSearchScreen> createState() => _PackageSearchScreenState();
}

class _PackageSearchScreenState extends State<PackageSearchScreen> {
  final PackageService _packageService = PackageService();
  List<Package> _packages = [];
  String _place = "";
  String _type = "";

  search() async {
    _packages = await _packageService.filterByPlaceByType(_place, _type);
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
          ExpansionTile(
              title: Text(
                "Places",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              children: [
                Wrap(
                  spacing: 8,
                  children: Place.values
                      .map((value) => InputChip(
                          selected: (_place == value.id),
                          onSelected: (onValue) {
                            setState(() {
                              _place = value.id;
                            });
                            search();
                          },
                          label: Text(value.description)))
                      .toList(),
                ),
              ]),
          ExpansionTile(
              title: Text(
                "Types",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              children: [
                Wrap(
                  spacing: 8,
                  children: Type.values
                      .map((value) => InputChip(
                          selected: (_type == value.id),
                          onSelected: (onValue) {
                            setState(() {
                              _type = value.id;
                            });
                            search();
                          },
                          label: Text(value.description)))
                      .toList(),
                ),
              ]),
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
                        : PackageDao().delete(widget.package.id);
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
