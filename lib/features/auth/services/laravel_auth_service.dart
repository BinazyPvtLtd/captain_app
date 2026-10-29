import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_config.dart';

class LaravelAuthService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> sendOtp({
  required String phone,
}) async {
  try {
    debugPrint('========== CAPTAIN SEND OTP ==========');
    debugPrint('API URL: ${ApiConfig.baseUrl}${ApiConfig.sendOtp}');
    debugPrint('METHOD: POST');
    debugPrint('REQUEST: mobile_number provided');

    final response = await _apiClient.dio.post(
      ApiConfig.sendOtp,
      data: {
        'mobile_number': phone,
      },
    );

    debugPrint('========== SEND OTP RESPONSE ==========');
    debugPrint('STATUS CODE: ${response.statusCode}');
    debugPrint('SUCCESS: ${response.data is Map ? response.data['success'] : 'unknown'}');
    debugPrint('MESSAGE: ${response.data is Map ? response.data['message'] : 'No message'}');
    debugPrint('======================================');

    return Map<String, dynamic>.from(response.data as Map);
  } on DioException catch (error) {
    debugPrint('========== SEND OTP API ERROR ==========');
    debugPrint('ERROR TYPE: ${error.type}');
    debugPrint('STATUS CODE: ${error.response?.statusCode}');
    debugPrint('ERROR MESSAGE: ${error.message}');

    final responseData = error.response?.data;

    if (responseData is Map) {
      debugPrint('BACKEND MESSAGE: ${responseData['message']}');
      debugPrint('BACKEND SUCCESS: ${responseData['success']}');
      debugPrint(
        'VALIDATION ERROR FIELDS: '
        '${responseData['errors'] is Map ? (responseData['errors'] as Map).keys.toList() : 'none'}',
      );
    }

    debugPrint('========================================');

    rethrow;
  } catch (error) {
    debugPrint('========== SEND OTP UNEXPECTED ERROR ==========');
    debugPrint('ERROR: ${error.runtimeType}');
    debugPrint('===============================================');

    rethrow;
  }
}

  Future<Map<String, dynamic>> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        ApiConfig.verifyOtp,
        data: {
          'mobile_number': phone,
          'otp': otp,
        },
      );

      debugPrint(
        'CAPTAIN VERIFY OTP STATUS: ${response.statusCode}',
      );

      return Map<String, dynamic>.from(response.data as Map);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data is Map
            ? e.response?.data['message'] ?? 'OTP verification failed'
            : 'OTP verification failed',
      );
    }
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
  try {
    debugPrint('========== CAPTAIN CURRENT USER API ==========');
    debugPrint('API URL: ${ApiConfig.baseUrl}${ApiConfig.currentUser}');
    debugPrint('METHOD: GET');

    final response = await _apiClient.dio.get(
      ApiConfig.currentUser,
    );

    debugPrint('========== CURRENT USER RESPONSE ==========');
    debugPrint('STATUS CODE: ${response.statusCode}');

    final responseData =
        Map<String, dynamic>.from(response.data as Map);

    debugPrint('SUCCESS: ${responseData['success']}');
    debugPrint('MESSAGE: ${responseData['message']}');

    final data = responseData['data'];

    if (data is Map) {
      debugPrint('DATA FIELDS: ${data.keys.toList()}');

      // Supports both data.user and direct data responses.
      final user = data['user'] is Map ? data['user'] : data;

      if (user is Map) {
        debugPrint('========== USER ROLE DETAILS ==========');
        debugPrint('ROLE: ${user['role']}');
        debugPrint('ROLES: ${user['roles']}');
        debugPrint('USER TYPE: ${user['user_type']}');
        debugPrint('ONBOARDING STATUS: ${user['onboarding_status']}');
        debugPrint('KYC STATUS: ${user['kyc_status']}');
      }
    }

    debugPrint('==========================================');

    return responseData;
  } on DioException catch (error) {
    debugPrint('========== CURRENT USER API ERROR ==========');
    debugPrint('ERROR TYPE: ${error.type}');
    debugPrint('STATUS CODE: ${error.response?.statusCode}');

    final responseData = error.response?.data;

    if (responseData is Map) {
      debugPrint('BACKEND MESSAGE: ${responseData['message']}');
      debugPrint('VALIDATION ERROR FIELDS: '
          '${responseData['errors'] is Map ? (responseData['errors'] as Map).keys.toList() : 'none'}');
    }

    debugPrint('==========================================');

    rethrow;
  } catch (error) {
    debugPrint('CURRENT USER ERROR TYPE: ${error.runtimeType}');
    rethrow;
  }
}

  Future<void> logout() async {
    final response = await _apiClient.dio.post(
      ApiConfig.logout,
    );

    final data = response.data;

    if (data is! Map || data['success'] != true) {
      throw Exception('Logout failed');
    }

    debugPrint('CAPTAIN LOGOUT API SUCCESS');
  }
}