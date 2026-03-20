import 'package:flutter/material.dart';

class SpeciesSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const SpeciesSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSearch,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        hintText: 'Type "/" to search by species name and country',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: const Icon(Icons.search, size: 40, color: Colors.grey),
        filled: true,
        fillColor: Colors.white30,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
