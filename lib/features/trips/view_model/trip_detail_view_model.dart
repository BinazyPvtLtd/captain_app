import 'package:flutter/material.dart';

import '../model/trip_detail_model.dart';

class TripDetailViewModel extends ChangeNotifier {
  final TripDetailModel _trip;

  TripDetailViewModel({
    required TripDetailModel trip,
  }) : _trip = trip;

  TripDetailModel get trip => _trip;

  // =========================================================
  // SUPPORT
  // =========================================================

  void contactSupport({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}