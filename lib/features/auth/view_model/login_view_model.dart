import 'package:flutter/material.dart';

import '../services/laravel_auth_service.dart';
import '../view/otp_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final LaravelAuthService _authService = LaravelAuthService();

  final TextEditingController phoneController =
      TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get isPhoneValid {
    return RegExp(
      r'^[0-9]{10}$',
    ).hasMatch(phoneController.text.trim());
  }

  void onPhoneChanged(String value) {
    notifyListeners();
  }

  Future<void> continueLogin(BuildContext context) async {
    if (_isLoading) return;

    final phone = phoneController.text.trim();

    if (!isPhoneValid) {
      _showError(context, 'Enter a valid 10-digit mobile number.');
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authService.sendOtp(
        phone: phone,
      );

      if (response['success'] != true) {
        throw Exception(
          response['message'] ?? 'Failed to send OTP',
        );
      }

      if (!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpScreen(
            phoneNumber: phone,
          ),
        ),
      );
    } catch (error) {
      if (context.mounted) {
        _showError(context, error.toString());
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}