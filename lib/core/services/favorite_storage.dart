import 'package:shared_preferences/shared_preferences.dart';

class FavoriteStorage {
  static const _key = "favorite_species";

  static Future<void> saveFavorites(List<int> favoriteId) async {
    final pref = await SharedPreferences.getInstance();
    List<String> stringList = favoriteId.map((id) => id.toString()).toList();
    await pref.setStringList(_key, stringList);
  }

  static Future<List<int>> loadFavorites() async {
    final pref = await SharedPreferences.getInstance();
    List<String>? stringList = pref.getStringList(_key);
    if (stringList == null) return [];
    return stringList.map((s) => int.parse(s)).toList();
  }

  static Future<void> addFavorite(int id) async {
    List<int> current = await loadFavorites();
    if (!current.contains(id)) {
      current.add(id);
      await saveFavorites(current);
    }
  }

  static Future<void> removeFavorite(int id) async {
    List<int> current = await loadFavorites();
    current.remove(id);
    await saveFavorites(current);
  }
}
