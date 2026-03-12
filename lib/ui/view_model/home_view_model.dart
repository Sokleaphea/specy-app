import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:specy_app/data/models/species.dart';
import 'package:specy_app/data/models/stats.dart';
import 'package:specy_app/data/repositories/species_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final SpeciesRepository repository;

  Stats stats = Stats(totalSpecies: 0, totalCountries: 0);
  Species? randomSpecies;

  HomeViewModel({required this.repository}) {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    stats = await repository.getStats();
    randomSpecies = await repository.getRandomSpecies();
    notifyListeners();
  }

  Map<int, bool> favorites = {};
  void toggleFavorite(int speciesId) {
    favorites[speciesId] = !(favorites[speciesId] ?? false);
    notifyListeners();
  }
  int getTotalViews() {
    final random = Random();
    return 100 + random.nextInt(100000);
  }
}
