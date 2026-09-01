import 'package:flutter/material.dart';

import '../model/active_delivery_model.dart';

class ActiveDeliveryViewModel extends ChangeNotifier {
  final ActiveDeliveryModel _delivery;

  ActiveDeliveryViewModel({
    required ActiveDeliveryModel delivery,
  }) : _delivery = delivery;

  ActiveDeliveryModel get delivery => _delivery;

  // =========================================================
  // NAVIGATE
  // =========================================================

  void navigate({
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
  // EMERGENCY / HELP
  // =========================================================

  void openEmergencyHelp({
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
}