import 'package:flutter/material.dart';
import 'package:turismo_app/dao/package_dao.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavoriteList(),
    );
  }
}

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List _favorites = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: PackageDao().fetchAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: $snapshot.error"),
          );
        } else {
          _favorites = snapshot.data ?? [];
          return ListView.builder(
            itemCount: _favorites.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(_favorites[index].name),
            ),
          );
        }
      },
    );
  }
}
