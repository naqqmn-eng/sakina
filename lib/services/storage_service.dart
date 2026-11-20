import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _countKey = 'sakina_count';
  static const String _dhikrKey = 'sakina_dhikr';
  static const String _targetKey = 'sakina_target';
  static const String _hapticsKey = 'sakina_haptics';
  static const String _totalKey = 'sakina_total';

  Future<int> getCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_countKey) ?? 0;
  }

  Future<void> saveCount(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_countKey, value);
  }

  Future<String> getDhikr() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dhikrKey) ?? 'سبحان الله';
  }

  Future<void> saveDhikr(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dhikrKey, value);
  }

  Future<int> getTarget() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_targetKey) ?? 33;
  }

  Future<void> saveTarget(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_targetKey, value);
  }

  Future<bool> getHaptics() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hapticsKey) ?? true;
  }

  Future<void> saveHaptics(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hapticsKey, value);
  }

  Future<int> getTotal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_totalKey) ?? 0;
  }

  Future<void> saveTotal(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_totalKey, value);
  }
}
