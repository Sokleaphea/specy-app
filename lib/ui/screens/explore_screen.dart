import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specy_app/core/utils/country.dart';
import 'package:specy_app/core/utils/open_wikipedia.dart';
import 'package:specy_app/ui/view_model/explore_view_model.dart';
import 'package:specy_app/ui/widgets/species_tile.dart';
import '../widgets/search_bar.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreVM = context.watch<ExploreViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                child: SpeciesSearchBar(
                  onSearch: (query) {
                    final exploreVm = context.read<ExploreViewModel>();
                    exploreVm.searchSpecies(query);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Found ",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        TextSpan(
                          text: "${exploreVM.stats.totalSpecies} ",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        TextSpan(
                          text: "results.",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final newDirection = exploreVM.sortDirection == "desc"
                          ? "asc"
                          : "desc";
                      exploreVM.changeSort(newDirection);
                    },
                    child: Transform.rotate(
                      angle: exploreVM.sortDirection == "desc" ? 0 : 3.1416,
                      child: Icon(Icons.arrow_downward, size: 28),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              exploreVM.filteredSpecies.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: exploreVM.filteredSpecies.map((species) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SpeciesTile(
                            id: species.id ?? 0,
                            scientificName: species.scientificName ?? "Unknown",
                            commonName: species.commonName ?? "Unknown",
                            countryName: getCountryName(species.isoCode ?? ''),
                            countryEmoji: getCountryEmoji(
                              species.isoCode ?? '',
                            ),
                            image: getSpeciesImage(species.id ?? 0),
                            onCountryTap: () {
                              openWikipedia(
                                countryName: getCountryName(species.isoCode!),
                              );
                            },
                            onSpeciesTap: () {
                              openWikipedia(
                                scientificName: species.scientificName,
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
