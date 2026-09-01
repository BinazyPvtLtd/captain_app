import 'dart:async';

import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  Timer? _navigationTimer;

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // =========================================================
  // INITIALIZE
  // =========================================================

  void initialize({
    required VoidCallback onComplete,
  }) {
    if (_isInitialized) {
      return;
    }

    _isInitialized = true;

    _navigationTimer = Timer(
      const Duration(seconds: 3),
      onComplete,
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _navigationTimer?.cancel();

    super.dispose();
  }
}