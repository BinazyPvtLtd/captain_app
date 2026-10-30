import '../services/laravel_auth_service.dart';

class CaptainRoleService {
  final LaravelAuthService _authService = LaravelAuthService();

  Future<bool> isCaptain() async {
    final response = await _authService.getCurrentUser();

    if (response['success'] != true) {
      return false;
    }

    final data = response['data'];

    if (data is! Map) {
      return false;
    }

    final user = data['user'] is Map
        ? data['user'] as Map
        : data;

    final role = user['role'];
    final roles = user['roles'];

    return role == 'captain' ||
        (role is Map && role['name'] == 'captain') ||
        (roles is List &&
            roles.any(
              (item) =>
                  item == 'captain' ||
                  (item is Map && item['name'] == 'captain'),
            ));
  }
}