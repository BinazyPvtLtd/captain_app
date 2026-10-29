import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';

class CaptainVehicleService {
  final Dio _dio = ApiClient().dio;

  Future<Map<String, dynamic>> createVehicle({
    required int vehicleTypeId,
    required String registrationNumber,
    required String make,
    required String model,
  }) async {
    try {
      debugPrint('========== CREATE CAPTAIN VEHICLE ==========');

      final requestBody = {
        'vehicle_type_id': vehicleTypeId,
        'registration_number': registrationNumber,
        'make': make,
        'model': model,
      };

      debugPrint('REQUEST BODY: $requestBody');

      final response = await _dio.post(
        ApiConfig.createCaptainVehicle,
        data: requestBody,
      );

      debugPrint('STATUS CODE: ${response.statusCode}');

      final responseData = response.data;

      if (responseData is! Map<String, dynamic>) {
        throw Exception('Invalid vehicle API response');
      }

      debugPrint('SUCCESS: ${responseData['success']}');
      debugPrint('MESSAGE: ${responseData['message']}');
      debugPrint('DATA: ${responseData['data']}');

      return responseData;
    } on DioException catch (error) {
      debugPrint('========== CREATE VEHICLE ERROR ==========');
      debugPrint('STATUS CODE: ${error.response?.statusCode}');
      debugPrint('RESPONSE: ${error.response?.data}');

      rethrow;
    }
  }
}