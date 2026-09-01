import 'package:flutter/material.dart';

import '../model/delivery_completed_model.dart';

class DeliveryCompletedViewModel extends ChangeNotifier {
  final DeliveryCompletedModel _delivery;

  DeliveryCompletedViewModel({
    required DeliveryCompletedModel delivery,
  }) : _delivery = delivery;

  DeliveryCompletedModel get delivery => _delivery;

  // =========================================================
  // DONE
  // =========================================================

  void completeFlow({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}