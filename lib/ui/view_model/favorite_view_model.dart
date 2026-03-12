import 'package:flutter/material.dart';
import 'package:specy_app/core/services/favorite_storage.dart';
import 'package:specy_app/data/models/species.dart';
import 'package:specy_app/data/models/stats.dart';
import 'package:specy_app/data/repositories/species_repository.dart';

class FavoriteViewModel extends ChangeNotifier {
  final SpeciesRepository repository;
  List<Species> speciesList = [];
  Set<int> favoriteSpecies = {};
  bool isLoading = true;
  Stats stats = Stats(totalSpecies: 0, totalCountries: 0);

  FavoriteViewModel({required this.repository}) {
    loadSpecies();
  }

  Future<void> loadSpecies() async {
    isLoading = true;
    notifyListeners();
    final savedFavorite = await FavoriteStorage.loadFavorites();
    favoriteSpecies = savedFavorite.toSet();
    speciesList = await repository.getAllSpecies();
    stats = await repository.getStats();

    isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(int speciesId) async {
    if (favoriteSpecies.contains(speciesId)) {
      favoriteSpecies.remove(speciesId);
      await FavoriteStorage.removeFavorite(speciesId);
    } else {
      favoriteSpecies.add(speciesId);
      await FavoriteStorage.addFavorite(speciesId);
    }
    notifyListeners();
  }

  List<Species> get favoriteSpeciesList =>
      speciesList.where((s) => favoriteSpecies.contains(s.id)).toList();
  void removeFromFavorite(int speciesId) async {
    favoriteSpecies.remove(speciesId);
    await FavoriteStorage.removeFavorite(speciesId);
    notifyListeners();
  }
}
