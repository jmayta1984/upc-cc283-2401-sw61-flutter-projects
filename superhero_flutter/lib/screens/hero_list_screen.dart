import 'package:flutter/material.dart';
import 'package:superhero_flutter/dao/hero_dao.dart';
import 'package:superhero_flutter/models/hero.dart';
import 'package:superhero_flutter/services/hero_service.dart';
import 'package:superhero_flutter/widgets/custom_search_bar.dart';

class HeroListScreen extends StatefulWidget {
  const HeroListScreen({super.key});

  @override
  State<HeroListScreen> createState() => _HeroListScreenState();
}

class _HeroListScreenState extends State<HeroListScreen> {
  String query = "";
  void onQueryChanged(String value) {
    setState(() {
      query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Super Hero"),
      ),
      body: Column(
        children: [
          CustomSearchBar(
            callback: (value) {
              onQueryChanged(value);
            },
          ),
          Expanded(child: HeroList(query: query)),
        ],
      ),
    );
  }
}

class HeroList extends StatefulWidget {
  const HeroList({super.key, required this.query});
  final String query;
  @override
  State<HeroList> createState() => _HeroListState();
}

class _HeroListState extends State<HeroList> {
  List _heros = [];
  final HeroService _heroService = HeroService();

  @override
  Widget build(BuildContext context) {
    if (widget.query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List>(
      future: _heroService.searchHeros(widget.query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("No se encontraron resultados"),
          );
        } else {
          _heros = snapshot.data ?? [];
          return ListView.builder(
            itemCount: _heros.length,
            itemBuilder: (context, index) {
              return HeroItem(hero: _heros[index]);
            },
          );
        }
      },
    );
  }
}

class HeroItem extends StatefulWidget {
  const HeroItem({super.key, required this.hero});
  final SuperHero hero;

  @override
  State<HeroItem> createState() => _HeroItemState();
}

class _HeroItemState extends State<HeroItem> {
  bool _isFavorite = false;
  final HeroDao _heroDao = HeroDao();
  @override
  Widget build(BuildContext context) {
    _heroDao.isFavorite(widget.hero).then(
      (value) {
        if (mounted) {
          setState(() {
            _isFavorite = value;
          });
        }
      },
    );
    return ListTile(
      leading: Image.network(widget.hero.image),
      title: Text(widget.hero.name),
      subtitle: Text(widget.hero.fullName),
      trailing: IconButton(
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
            _isFavorite
                ? _heroDao.insert(widget.hero)
                : _heroDao.delete(widget.hero);
          },
          icon: Icon(
            Icons.favorite,
            color: _isFavorite ? Colors.red : Colors.grey,
          )),
    );
  }
}
