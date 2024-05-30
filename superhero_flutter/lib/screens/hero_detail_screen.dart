import 'package:flutter/material.dart';
import 'package:superhero_flutter/models/hero.dart';

class HeroDetailScreen extends StatelessWidget {
  const HeroDetailScreen({super.key, required this.superHero});
  final SuperHero superHero;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              
              tag: superHero.id,
              child: Image.network(
                superHero.image,
                width: width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(superHero.name),
            Text(superHero.fullName),
            HeroStats(stats: superHero.stats),
          ],
        ),
      ),
    );
  }
}

class HeroStats extends StatelessWidget {
  const HeroStats({super.key, required this.stats});
  final PowerStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: const Text("Powerstats"),
        children: [
          Slider(
            max: 100,
            value: double.parse(stats.intelligence),
            onChanged: (value) {},
          ),
          Slider(
            max: 100,
            value: double.parse(stats.strength),
            onChanged: (value) {},
          ),
          Slider(
            max: 100,
            value: double.parse(stats.speed),
            onChanged: (value) {},
          ),
          Slider(
            max: 100,
            value: double.parse(stats.durability),
            onChanged: (value) {},
          ),
          Slider(
            max: 100,
            value: double.parse(stats.power),
            onChanged: (value) {},
          ),
          Slider(
            max: 100,
            value: double.parse(stats.combat),
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
