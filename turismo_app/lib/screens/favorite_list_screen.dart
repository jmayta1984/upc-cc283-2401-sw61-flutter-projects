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
  final PackageDao _packageDao = PackageDao();

  fetchFavorites() async {
    _favorites = await _packageDao.fetchAll();
    if (mounted) {
      setState(() {
        _favorites = _favorites;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchFavorites();
    return ListView.builder(
      itemCount: _favorites.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(_favorites[index].name),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            _packageDao.delete(_favorites[index].id);
          },
        ),
      ),
    );
  }
}
