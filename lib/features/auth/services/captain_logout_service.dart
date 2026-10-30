import 'package:flutter/foundation.dart';

import '../../../core/storage/token_storage.dart';
import 'laravel_auth_service.dart';

class CaptainLogoutService {
  final LaravelAuthService _authService =
      LaravelAuthService();

  Future<void> logout() async {
    try {
      debugPrint('Calling Captain logout API...');

      await _authService.logout();

      debugPrint('Backend logout successful');
    } catch (error) {
      debugPrint(
        'Backend logout failed: ${error.runtimeType}',
      );
    } finally {
      // Delete the locally saved token.
      await TokenStorage.deleteToken();

      debugPrint('Local session cleared');
    }
  }
}