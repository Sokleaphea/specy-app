import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:specy_app/core/services/api_service.dart';
import 'package:specy_app/data/repositories/species_repository.dart';
import 'package:specy_app/theme/theme.dart';
import 'package:specy_app/ui/view_model/explore_view_model.dart';
import 'package:specy_app/ui/view_model/favorite_view_model.dart';
import 'package:specy_app/ui/view_model/home_view_model.dart';
import 'ui/screens/explore_screen.dart';
import './ui/screens/favorite_screen.dart';
import './ui/screens/home_screen.dart';

void main() async {
  final apiService = ApiService();
  final repository = SpeciesRepository(apiService: apiService);
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(repository: repository),
          child: HomeScreen(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExploreViewModel(repository: repository),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteViewModel(repository: repository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  int _currentIndex = 0;

  final List<Widget> _pages = [HomeScreen(), ExploreScreen(), FavoriteScreen()];

  @override
  void initState() {
    super.initState();
    _initPlugin();
  }

  Future<void> _initPlugin() async {
    await CountryCodes.init();
    setState(() => _initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: Colors.grey)),
          ),
          child: BottomNavigationBar(
            onTap: (index) => {
              setState(() {
                _currentIndex = index;
              }),
            },
            selectedItemColor: Colors.redAccent,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                label: "Favorite",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
