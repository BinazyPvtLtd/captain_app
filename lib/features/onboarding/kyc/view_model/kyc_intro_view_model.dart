import 'package:flutter/material.dart';

class KycIntroViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> startVerification({
    required VoidCallback onSuccess,
  }) async {
    _setLoading(true);

    try {
      // Later:
      // API / KYC state initialization can happen here.

      await Future.delayed(
        const Duration(
          milliseconds: 400,
        ),
      );

      onSuccess();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}