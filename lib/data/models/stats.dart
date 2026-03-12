class Stats {
  final int totalSpecies;
  final int totalCountries;

  Stats({
    required this.totalSpecies,
    required this.totalCountries,
  });

  // factory Stats.fromJson(Map<String, dynamic> json) {
  //   return Stats(
  //     totalSpecies: json['total_species'],
  //     totalCountries: json['total_counties'],
  //     totalViews: json['total_views'],
  //   );
  // }
  factory Stats.fromJson({
    required Map<String, dynamic> speciesJson,
    required Map<String, dynamic> countriesJson,
  }) {
    return Stats(
      totalSpecies: speciesJson['count'] ?? 0,
      totalCountries: countriesJson['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_species': totalSpecies,
      'total_countries': totalCountries,
    };
  }
}
