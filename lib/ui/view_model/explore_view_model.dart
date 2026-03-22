import 'package:flutter/material.dart';
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
  int currentPage = 1;
  final int pageSize = 20;
  bool hasMore = true;
  bool isLoading = false;
  final TextEditingController searchController = TextEditingController();
  ExploreViewModel({required this.repository}) {
    loadSpecies();
  }
  Future<void> loadSpecies() async {
    currentPage = 1;
    hasMore = true;
    speciesList.clear();
    filteredSpecies.clear();
    notifyListeners();
    await fetchMoreData();
  }

  Future<void> fetchMoreData() async {
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();

    final newData = await repository.filterSpecies(
      currentQuery,
      sortDirection,
      page: currentPage,
      limit: pageSize,
    );
    if (newData.isEmpty) {
      hasMore = false;
    } else {
      speciesList.addAll(newData);
      filteredSpecies = List.from(speciesList);
      currentPage++;
    }
    stats = Stats(
      totalSpecies: filteredSpecies.length,
      totalCountries: filteredSpecies.map((s) => s.isoCode!).toSet().length,
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> search(String query) async {
    currentQuery = query;
    currentPage = 1;
    hasMore = true;
    speciesList.clear();
    filteredSpecies.clear();
    await fetchMoreData();
  }

  void changeSort(String newDirection) async {
    sortDirection = newDirection;
    currentPage = 1;
    hasMore = true;
    speciesList.clear();
    await fetchMoreData();
  }
}
