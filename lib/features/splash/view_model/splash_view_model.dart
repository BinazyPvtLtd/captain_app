import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/storage/token_storage.dart';
import '../../auth/services/laravel_auth_service.dart';

enum SplashDestination {
  login,
  onboarding,
  home,
}

class SplashViewModel extends ChangeNotifier {
  final LaravelAuthService _authService = LaravelAuthService();

  Timer? _navigationTimer;

  bool _isInitialized = false;
  bool _isDisposed = false;

  bool get isInitialized => _isInitialized;

  void initialize({
    required void Function(SplashDestination destination) onComplete,
  }) {
    if (_isInitialized) return;

    _isInitialized = true;

    _navigationTimer = Timer(
      const Duration(seconds: 3),
      () async {
        // final destination = await _checkSession();

        SplashDestination destination;

try {
  destination = await _checkSession();
} catch (error) {
  debugPrint('Session check unavailable: ${error.runtimeType}');

  // Temporary fallback; production mein retry UI use karo.
  destination = SplashDestination.onboarding;
}

        if (_isDisposed) return;

        onComplete(destination);
      },
    );
  }

  Future<SplashDestination> _checkSession() async {
    try {
      final token = await TokenStorage.getToken();

      if (token == null || token.isEmpty) {
        debugPrint('🔓 No token found');
        return SplashDestination.login;
      }

      final response = await _authService.getCurrentUser();

      if (response['success'] != true) {
        return SplashDestination.login;
      }

      final data = response['data'];

      if (data is! Map) {
        throw Exception('Invalid user response');
      }

      final user = data['user'] is Map
          ? data['user'] as Map
          : data;

      final role = user['role'];
      final roles = user['roles'];

      final isCaptain =
          role == 'captain' ||
          (role is Map && role['name'] == 'captain') ||
          (roles is List &&
              roles.any(
                (item) =>
                    item == 'captain' ||
                    (item is Map && item['name'] == 'captain'),
              ));

      if (isCaptain) {
        debugPrint('🚚 Captain role found → Home');
        return SplashDestination.home;
      }

      debugPrint('📋 Onboarding required');
      return SplashDestination.onboarding;
    } on DioException catch (error) {
      debugPrint(
        'Session API status: ${error.response?.statusCode}',
      );

      if (error.response?.statusCode == 401) {
        await TokenStorage.deleteToken();
        return SplashDestination.login;
      }

      // A temporary network failure is not proof of logout.
      rethrow;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _navigationTimer?.cancel();
    super.dispose();
  }
}