import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Flutter demo"),
        ),
        body:  PersonList(),
        /*body: Center(
          child: Text("$count"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: const Icon(Icons.add),
        ),*/
      ),
    );
  }
}

class PersonList extends StatelessWidget {
  PersonList({super.key});
  final List people = ["Carmen", "Luis", "Francisco"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(people[index])
          );
        });
  }
}
