import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProgressStorage {
  static const String _screenKey = 'captain_onboarding_screen';
  static const String _vehicleTypeIdKey = 'captain_vehicle_type_id';
  static const String _vehicleTypeNameKey = 'captain_vehicle_type_name';

  static Future<void> saveScreen(String screen) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_screenKey, screen);
  }

  static Future<String?> getSavedScreen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_screenKey);
  }

  static Future<void> saveVehicleType({
    required int id,
    required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_vehicleTypeIdKey, id);
    await prefs.setString(_vehicleTypeNameKey, name);
  }

  static Future<int?> getVehicleTypeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_vehicleTypeIdKey);
  }

  static Future<String?> getVehicleTypeName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_vehicleTypeNameKey);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_screenKey);
    await prefs.remove(_vehicleTypeIdKey);
    await prefs.remove(_vehicleTypeNameKey);
  }
}