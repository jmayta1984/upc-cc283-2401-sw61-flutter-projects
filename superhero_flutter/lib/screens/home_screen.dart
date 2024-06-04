import 'package:flutter/material.dart';
import 'package:superhero_flutter/screens/favorite_hero_list_screen.dart';
import 'package:superhero_flutter/screens/hero_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = const [HeroListScreen(), FavoriteHeroListScreen()];
  final List<BottomNavigationBarItem> _options = const [
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        items: _options,
      ),
    );
  }
}
