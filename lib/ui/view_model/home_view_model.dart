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

  // Timer? _timer;
  Timer? _refreshTimer;
  // bool _isLoading = false;

  final int refreshSecond = 10;
  int remainingSeconds = 10;
  int? totalViews = 0;

  HomeViewModel({required this.repository}) {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    final statsFuture = repository.getStats();
    final randomSpeciesFuture = repository.getRandomSpecies();

    stats = await statsFuture;
    randomSpecies = await randomSpeciesFuture;
    totalViews = 100 + Random().nextInt(10000);
    notifyListeners();
  }

  // void startTimer() {
  //   _refreshTimer?.cancel();
  //   _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) async {
  //     if (remainingSeconds > 0) {
  //       remainingSeconds--;
  //       notifyListeners();
  //     } else {
  //       randomSpecies = await repository.getRandomSpecies();
  //       remainingSeconds = refreshSecond;
  //       notifyListeners();
  //     }
  //   });
  // }

  // void stopTimer() {
  //   _refreshTimer?.cancel();
  // }

  Map<int, bool> favorites = {};
  void toggleFavorite(int speciesId) {
    favorites[speciesId] = !(favorites[speciesId] ?? false);
    notifyListeners();
  }

  double get progressPercentage {
    return 1 - (remainingSeconds / refreshSecond);
  }

  // int getTotalViews() {
  //   final random = Random();
  //   return 100 + random.nextInt(100000);
  // }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}
