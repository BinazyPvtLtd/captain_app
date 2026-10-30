import 'package:driver_app/core/storage/token_storage.dart';
import 'package:driver_app/features/auth/services/laravel_auth_service.dart';
import 'package:flutter/material.dart';

import '../model/driver_profile_model.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({
    DriverProfileModel? profile,
  }) : _profile = profile ??
            const DriverProfileModel(
              name: 'Rahul Kumar',
              driverId: 'PTG2847',
              rating: 4.8,
            );

  final DriverProfileModel _profile;


  final LaravelAuthService _authService = LaravelAuthService();

  DriverProfileModel get profile => _profile;

  bool _isLoggingOut = false;

  bool get isLoggingOut => _isLoggingOut;

  // =========================================================
  // PROFILE
  // =========================================================

  void editProfile({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // MENU ITEM
  // =========================================================

  void openSection({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  Future<void> logout({
  required VoidCallback onSuccess,
}) async {
  if (_isLoggingOut) return;

  _isLoggingOut = true;
  notifyListeners();

  try {
    debugPrint('CAPTAIN LOGOUT STARTED');

    try {
      await _authService.logout();

      debugPrint('CAPTAIN SERVER LOGOUT SUCCESS');
    } catch (error) {
      debugPrint('CAPTAIN SERVER LOGOUT FAILED: $error');

      // Local logout still proceeds.
      // The server token may remain valid if revocation failed.
    }

    await TokenStorage.deleteToken();

    debugPrint('CAPTAIN LOCAL TOKEN DELETED');

    onSuccess();
  } catch (error) {
    debugPrint('CAPTAIN LOCAL LOGOUT FAILED: $error');
    rethrow;
  } finally {
    _isLoggingOut = false;
    notifyListeners();
  }
}
}