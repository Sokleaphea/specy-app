import 'package:flutter/material.dart';
import 'package:specy_app/core/utils/country.dart';
import 'package:specy_app/data/models/species.dart';
import 'package:specy_app/data/models/stats.dart';
import 'package:specy_app/data/repositories/species_repository.dart';

class ExploreViewModel extends ChangeNotifier {
  final SpeciesRepository repository;
  List<Species> speciesList = [];
  List<Species> filteredSpecies = [];
  String currentQuery = '';
  Stats stats = Stats(totalSpecies: 0, totalCountries: 0);
  String sortDirection = "asc";

  ExploreViewModel({required this.repository}) {
    loadSpecies();
  }
  Future<void> loadSpecies() async {
    speciesList = await repository.getAllSpecies();
    filteredSpecies = speciesList;
    stats = await repository.getStats();
    notifyListeners();
  }

  void searchSpecies(String query) {
    if (query.isEmpty) {
      filteredSpecies = speciesList;
    } else {
      filteredSpecies = speciesList.where((s) {
        final name = s.commonName?.toLowerCase() ?? '';
        final scientific = s.scientificName?.toLowerCase() ?? '';
        final country = getCountryName(s.isoCode ?? '').toLowerCase();
        return name.contains(query.toLowerCase()) ||
            scientific.contains(query.toLowerCase()) ||
            country.contains(query.toLowerCase());
      }).toList();
    }
    stats = Stats(
      totalSpecies: filteredSpecies.length,
      totalCountries: filteredSpecies.map((s) => s.isoCode).toSet().length,
    );

    notifyListeners();
  }

  Future<void> search(String query) async {
    currentQuery = query;
    speciesList = await repository.filterSpecies(query, sortDirection);
    filteredSpecies = speciesList;
    stats = Stats(
      totalSpecies: filteredSpecies.length,
      totalCountries: filteredSpecies.map((s) => s.isoCode).toSet().length,
    );
    notifyListeners();
  }

  void changeSort(String newDirection) async {
    sortDirection = newDirection;
    await search(currentQuery);
    filteredSpecies = speciesList;
    notifyListeners();
  }
}
