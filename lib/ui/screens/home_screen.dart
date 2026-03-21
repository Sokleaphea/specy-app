import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:specy_app/core/utils/country.dart';
import 'package:specy_app/core/utils/open_wikipedia.dart';
import 'package:specy_app/ui/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:specy_app/ui/widgets/favorite_button.dart';
import '../widgets/specy_divider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeViewModel homeVm;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    homeVm = context.read<HomeViewModel>();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) async {
    if (status == AnimationStatus.completed) {
      await homeVm.loadHomeData();
      _controller.forward(from: 0);
    }
  });
  
  _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HomeView(controller: _controller,);
  }
}

class _HomeView extends StatelessWidget {
  final AnimationController controller;
  const _HomeView({required this.controller});

  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();
    if (homeVM.stats.totalSpecies == 0 && homeVM.stats.totalCountries == 0) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final species = homeVM.randomSpecies!;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 40),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Mapping amazing endemic species all over the world",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${homeVM.stats.totalSpecies} ",
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          text: "Species",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SpecyDivider(),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${homeVM.stats.totalCountries} ",
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          text: "Countries",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SpecyDivider(),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${homeVM.totalViews} ",
                          style: TextStyle(color: Colors.red),
                        ),
                        TextSpan(
                          text: "Views",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      openWikipedia(scientificName: species.scientificName!);
                    },
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: 80,
                              lineWidth: 8,
                              percent: controller.value,
                              progressColor: Colors.blue,
                              backgroundColor: Colors.grey.shade300,
                              circularStrokeCap: CircularStrokeCap.round,
                              animation: false,
                            ),
                            ClipOval(
                              child: Image.network(
                                species.image!,
                                width: 150,
                                height: 150,
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FavoriteButton(
                                      speciesId: species.id!,
                                      size: 24,
                                    ),
                                  ),
                                  onTap: () {
                                    final homeVm = context
                                        .read<HomeViewModel>();
                                    homeVm.toggleFavorite(species.id!);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            Text(
                              species.commonName!,
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 10),
                            Text(species.scientificName!),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      openWikipedia(
                        countryName: getCountryName(species.isoCode!),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getCountryEmoji(species.isoCode!),
                          style: TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 8),
                        Text(getCountryName(species.isoCode!)),
                      ],
                    ),
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: "Next animal in: ",
                  //         style: TextStyle(color: Colors.black, fontSize: 16),
                  //       ),
                  //       TextSpan(
                  //         text: "${homeVM.remainingSeconds}",
                  //         style: TextStyle(color: Colors.red),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Text("Next animal in: ${homeVM.remainingSeconds}s"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
