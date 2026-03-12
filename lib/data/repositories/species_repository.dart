import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:specy_app/core/services/api_service.dart';
import 'package:specy_app/data/models/species.dart';
import 'package:specy_app/data/models/stats.dart';

class SpeciesRepository {
  final ApiService apiService;
  SpeciesRepository({required this.apiService});

  Future<Species> getRandomSpecies() async {
    final randomSpecies = await apiService.get("/v1/random");
    return Species.fromJson(randomSpecies);
  }

  Future<List<Species>> getAllSpecies() async {
    final allSpecies = await apiService.get("/v1/species");
    return (allSpecies as List).map((json) => Species.fromJson(json)).toList();
  }

  Future<Stats> getStats() async {
    // final allStats = await Future.wait([
    //   apiService.get("/v1/countrycount"),
    //   apiService.get("/v1/speciescount"),
    //   apiService.get("/v1/viewsCount"),
    // ]);
    // print(allStats);
    // return Stats.fromJson(
    //   speciesJson: allStats[0],
    //   countriesJson: allStats[1],
    //   viewsJson: allStats[2],
    // );
    final countriesJson = await apiService.get("/v1/countrycount");
    final speciesJson = await apiService.get("/v1/speciescount");
    return Stats.fromJson(
      speciesJson: speciesJson,
      countriesJson: countriesJson,
    );
  }

  Future<List<Species>> filterSpecies(
    String query,
    String sortDirection, {
      int page = 1,
      int limit = 20
    }
  ) async {
    final url =
        "https://aes.shenlu.me/api/search?q=$query&sortDirection=$sortDirection";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List<dynamic> results = decoded['results'];
      return results.map((r) => Species.fromJson(r)).toList();
    } else {
      throw Exception("Failed to fetch data");
    }
  }
}
