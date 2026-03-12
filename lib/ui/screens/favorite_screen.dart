import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specy_app/core/utils/country.dart';
import 'package:specy_app/core/utils/open_wikipedia.dart';
import 'package:specy_app/ui/widgets/species_tile.dart';
import '../view_model/favorite_view_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteVm = context.watch<FavoriteViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: favoriteVm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : favoriteVm.favoriteSpeciesList.isEmpty
              ? const Center(child: Text("No favorites yet"))
              : Column(
                  children: favoriteVm.favoriteSpeciesList.map((species) {
                    return Dismissible(
                      key: ValueKey(species.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        favoriteVm.removeFromFavorite(species.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${species.commonName ?? 'Species'} removed",
                            ),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: "Undo",
                              onPressed: () {
                                favoriteVm.toggleFavorite(species.id!);
                              },
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SpeciesTile(
                          id: species.id ?? 0,
                          scientificName: species.scientificName ?? 'Unknown',
                          commonName: species.commonName ?? 'Unknown',
                          countryName: species.isoCode != null
                              ? getCountryName(species.isoCode!)
                              : 'Unknown',
                          countryEmoji: species.isoCode != null
                              ? getCountryEmoji(species.isoCode!)
                              : '',
                          image: getSpeciesImage(species.id!),
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
                      ),
                    );
                  }).toList(),
                  // children: favoriteVm.favoriteSpeciesList.map((species) => {
                ),
        ),
      ),
    );
  }
}
