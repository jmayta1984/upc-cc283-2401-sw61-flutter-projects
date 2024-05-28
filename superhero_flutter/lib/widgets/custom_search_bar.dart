import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.callback});
  final Function callback;

  onQueryChanged(String newQuery) {
    callback(newQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            hintText: "Search hero by name",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
