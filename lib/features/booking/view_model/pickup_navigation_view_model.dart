import 'package:flutter/material.dart';

import '../model/pickup_navigation_model.dart';

class PickupNavigationViewModel extends ChangeNotifier {
  final PickupNavigationModel _booking;

  PickupNavigationViewModel({
    required PickupNavigationModel booking,
  }) : _booking = booking;

  PickupNavigationModel get booking => _booking;

  bool _isStartingTrip = false;

  bool get isStartingTrip => _isStartingTrip;

  // =========================================================
  // OPEN MAPS
  // =========================================================

  void openMaps({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // CALL CUSTOMER
  // =========================================================

  void callCustomer({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // RECENTER MAP
  // =========================================================

  void recenterMap({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // START TRIP
  // =========================================================

  Future<void> startTrip({
    required VoidCallback onSuccess,
  }) async {
    if (_isStartingTrip) {
      return;
    }

    _setStartingTrip(true);

    try {
      // TODO:
      // await bookingRepository.startTrip(
      //   bookingId: _booking.bookingId,
      // );

      await Future.delayed(
        const Duration(
          milliseconds: 400,
        ),
      );

      onSuccess();
    } finally {
      _setStartingTrip(false);
    }
  }

  void _setStartingTrip(
    bool value,
  ) {
    _isStartingTrip = value;

    notifyListeners();
  }
}