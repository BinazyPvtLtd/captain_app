import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_config.dart';

class CaptainOnboardingService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> applyForCaptain({
    required int vehicleTypeId,
  }) async {
    try {
      debugPrint('========== CAPTAIN ONBOARDING APPLY ==========');

      debugPrint(
        'SELECTED VEHICLE TYPE ID: $vehicleTypeId',
      );

      final response = await _apiClient.dio.post(
        ApiConfig.captainOnboardingApply,
        data: {
          'vehicle_type_id': vehicleTypeId,
        },
      );

      final result = Map<String, dynamic>.from(
        response.data as Map,
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('SUCCESS: ${result['success']}');
      debugPrint('MESSAGE: ${result['message']}');

      if (result['success'] != true) {
        throw Exception(
          result['message'] ?? 'Application failed',
        );
      }

      final data = result['data'];

      if (data is Map) {
        debugPrint(
          'ONBOARDING STATUS: ${data['onboarding_status']}',
        );
        debugPrint(
          'KYC STATUS: ${data['kyc_status']}',
        );
      }

      return result;
    } on DioException catch (error) {
      debugPrint('========== ONBOARDING APPLY ERROR ==========');
      debugPrint('STATUS CODE: ${error.response?.statusCode}');

      final data = error.response?.data;

      if (data is Map) {
        debugPrint('MESSAGE: ${data['message']}');
      }

      rethrow;
    }
  }
}