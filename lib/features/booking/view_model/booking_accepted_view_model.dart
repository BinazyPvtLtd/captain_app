import 'package:flutter/material.dart';

import '../model/accepted_booking_model.dart';

class BookingAcceptedViewModel extends ChangeNotifier {
  final AcceptedBookingModel _booking;

  BookingAcceptedViewModel({
    required AcceptedBookingModel booking,
  }) : _booking = booking;

  AcceptedBookingModel get booking => _booking;

  // =========================================================
  // NAVIGATE
  // =========================================================

  void navigateToPickup({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void messageCustomer({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // CALL
  // =========================================================

  void callCustomer({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}