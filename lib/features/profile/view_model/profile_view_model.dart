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
    if (_isLoggingOut) {
      return;
    }

    _isLoggingOut = true;
    notifyListeners();

    try {
      // TODO:
      // await authRepository.signOut();

      await Future.delayed(
        const Duration(
          milliseconds: 350,
        ),
      );

      onSuccess();
    } finally {
      _isLoggingOut = false;
      notifyListeners();
    }
  }
}