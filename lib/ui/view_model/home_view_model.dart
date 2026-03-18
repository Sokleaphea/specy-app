import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:specy_app/data/models/species.dart';
import 'package:specy_app/data/models/stats.dart';
import 'package:specy_app/data/repositories/species_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final SpeciesRepository repository;

  Stats stats = Stats(totalSpecies: 0, totalCountries: 0);
  Species? randomSpecies;

  Timer? _timer;
  bool _isLoading = false;

  HomeViewModel({required this.repository}) {
    loadHomeData();
    startAutoRefresh();
  }

  Future<void> loadHomeData() async {
    final statsFuture = repository.getStats();
    final randomSpeciesFuture = repository.getRandomSpecies();

    stats = await statsFuture;
    randomSpecies = await randomSpeciesFuture;
    notifyListeners();
  }

  void startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (_isLoading) return;

      _isLoading = true;
      randomSpecies = await repository.getRandomSpecies();
      _isLoading = false;
      notifyListeners();
    });
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
