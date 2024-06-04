import 'package:flutter/material.dart';
import 'package:superhero_flutter/dao/hero_dao.dart';
import 'package:superhero_flutter/models/favorite_hero.dart';

class FavoriteHeroListScreen extends StatefulWidget {
  const FavoriteHeroListScreen({super.key});

  @override
  State<FavoriteHeroListScreen> createState() => _FavoriteHeroListScreenState();
}

class _FavoriteHeroListScreenState extends State<FavoriteHeroListScreen> {
  List<FavoriteHero> _favoriteHeros = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<List<FavoriteHero>>(
          future: HeroDao().fetchAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("$snapshot.error"),
              );
            } else {
              _favoriteHeros = snapshot.data ?? [];
              return ListView.builder(
                itemCount: _favoriteHeros.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(_favoriteHeros[index].path),
                      title: Text(_favoriteHeros[index].name),
                      subtitle: Text(_favoriteHeros[index].fullName),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
