import 'package:flutter/material.dart';

import '../model/trip_details_model.dart';

class TripDetailsViewModel extends ChangeNotifier {
  final TripDetailsModel _trip;

  TripDetailsViewModel({
    required TripDetailsModel trip,
  }) : _trip = trip;

  TripDetailsModel get trip => _trip;

  // =========================================================
  // START TRIP
  // =========================================================

  bool _isStartingTrip = false;

  bool get isStartingTrip => _isStartingTrip;

  // =========================================================
  // CALL CUSTOMER
  // =========================================================

  void callCustomer({
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
      // =====================================================
      // TODO:
      //
      // await bookingRepository.startTrip(
      //   bookingId: _trip.bookingId,
      // );
      //
      // =====================================================

      await Future.delayed(
        const Duration(
          milliseconds: 450,
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