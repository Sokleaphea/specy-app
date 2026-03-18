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
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SpeciesSearchBar(
                onSearch: (query) {
                  context.read<ExploreViewModel>().search(query);
                },
              ),
              SizedBox(height: 16),
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
                          text: "results",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final newDirection = exploreVM.sortDirection == 'desc'
                          ? "asc"
                          : "desc";
                      exploreVM.changeSort(newDirection);
                    },
                    child: Transform.rotate(
                      angle: exploreVM.sortDirection == 'desc' ? 0 : 3.1416,
                      child: Icon(Icons.arrow_downward, size: 28),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: exploreVM.filteredSpecies.isEmpty && exploreVM.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount:
                            exploreVM.filteredSpecies.length +
                            (exploreVM.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index < exploreVM.filteredSpecies.length) {
                            final species = exploreVM.filteredSpecies[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SpeciesTile(
                                id: species.id ?? 0,
                                scientificName:
                                    species.scientificName ?? "Unknown",
                                commonName: species.commonName ?? 'Unknown',
                                countryName: getCountryName(
                                  species.isoCode ?? '',
                                ),
                                countryEmoji: getCountryEmoji(
                                  species.isoCode ?? '',
                                ),
                                image: getSpeciesImage(species.id ?? 0),
                                onCountryTap: () {
                                  openWikipedia(
                                    countryName: getCountryName(
                                      species.isoCode!,
                                    ),
                                  );
                                },
                                onSpeciesTap: () {
                                  openWikipedia(
                                    scientificName: species.scientificName,
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
