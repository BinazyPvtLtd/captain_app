import 'dart:async';

import 'package:flutter/material.dart';

import '../model/delivery_request_model.dart';

class DeliveryRequestViewModel extends ChangeNotifier {
  DeliveryRequestViewModel({
    required DeliveryRequestModel request,
  }) : _request = request {
    _startTimer();
  }

  // =========================================================
  // REQUEST
  // =========================================================

  final DeliveryRequestModel _request;

  DeliveryRequestModel get request => _request;

  // =========================================================
  // TIMER
  // =========================================================

  static const int _initialSeconds = 18;

  int _remainingSeconds = _initialSeconds;

  int get remainingSeconds => _remainingSeconds;

  double get timerProgress =>
      _remainingSeconds / _initialSeconds;

  Timer? _timer;

  // =========================================================
  // PROCESSING
  // =========================================================

  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  // =========================================================
  // ACCEPT SWIPE
  // =========================================================

  double _acceptOffset = 0;

  double get acceptOffset => _acceptOffset;

  // =========================================================
  // REJECT SWIPE
  // =========================================================

  double _rejectOffset = 0;

  double get rejectOffset => _rejectOffset;

  // =========================================================
  // CALLBACKS
  // =========================================================

  VoidCallback? _onAccept;
  VoidCallback? _onReject;
  VoidCallback? _onExpired;

  void configureCallbacks({
    VoidCallback? onAccept,
    VoidCallback? onReject,
    VoidCallback? onExpired,
  }) {
    _onAccept = onAccept;
    _onReject = onReject;
    _onExpired = onExpired;
  }

  // =========================================================
  // ACCEPT DRAG
  // =========================================================

  void updateAcceptSwipe({
  required double delta,
  required double maxDrag,
}) {
  if (_isProcessing) return;

  _acceptOffset += delta;

  _acceptOffset = _acceptOffset.clamp(
    0.0,
    maxDrag,
  );

  notifyListeners();
}

Future<void> completeAcceptSwipe(
  double maxDrag,
) async {
  if (_isProcessing) return;

  final double threshold =
      maxDrag * 0.85;

  if (_acceptOffset >= threshold) {
    await acceptBooking();
    return;
  }

  _acceptOffset = 0;

  notifyListeners();
}

  // =========================================================
  // REJECT DRAG
  // =========================================================

 void updateRejectSwipe({
  required double delta,
  required double maxDrag,
}) {
  if (_isProcessing) return;

  _rejectOffset += delta;

  _rejectOffset = _rejectOffset.clamp(
    -maxDrag,
    0.0,
  );

  notifyListeners();
}

Future<void> completeRejectSwipe(
  double maxDrag,
) async {
  if (_isProcessing) return;

  final double threshold =
      -(maxDrag * 0.85);

  if (_rejectOffset <= threshold) {
    await rejectBooking();
    return;
  }

  _rejectOffset = 0;

  notifyListeners();
}
  // =========================================================
  // ACCEPT BOOKING
  // =========================================================

  Future<void> acceptBooking() async {
    if (_isProcessing) return;

    _setProcessing(true);
    _timer?.cancel();

    try {
      // TODO:
      // await bookingRepository.acceptBooking(
      //   _request.id,
      // );

      await Future.delayed(
        const Duration(
          milliseconds: 300,
        ),
      );

      _acceptOffset = 0;
      _rejectOffset = 0;

      _onAccept?.call();
    } finally {
      _setProcessing(false);
    }
  }

  // =========================================================
  // REJECT BOOKING
  // =========================================================

  Future<void> rejectBooking() async {
    if (_isProcessing) return;

    _setProcessing(true);
    _timer?.cancel();

    try {
      // TODO:
      // await bookingRepository.rejectBooking(
      //   _request.id,
      // );

      await Future.delayed(
        const Duration(
          milliseconds: 300,
        ),
      );

      _acceptOffset = 0;
      _rejectOffset = 0;

      _onReject?.call();
    } finally {
      _setProcessing(false);
    }
  }

  // =========================================================
  // TIMER
  // =========================================================

  void _startTimer() {
    _timer?.cancel();

    _remainingSeconds = _initialSeconds;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;

          notifyListeners();
          return;
        }

        timer.cancel();

        _onExpired?.call();
      },
    );
  }

  // =========================================================
  // PROCESSING
  // =========================================================

  void _setProcessing(
    bool value,
  ) {
    _isProcessing = value;

    notifyListeners();
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}