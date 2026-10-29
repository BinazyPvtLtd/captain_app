import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';

import '../model/vehicles_type_model.dart';

class VehicleTypeService {
  final ApiClient _apiClient = ApiClient();

  Future<List<VehiclesTypeModel>> getVehicleTypes() async {
    try {
      debugPrint('========== GET VEHICLE TYPES ==========');

      final response = await _apiClient.dio.get(
        ApiConfig.vehicleTypes,
      );

      debugPrint('STATUS CODE: ${response.statusCode}');

      final responseData =
          Map<String, dynamic>.from(response.data as Map);

      debugPrint('SUCCESS: ${responseData['success']}');
      debugPrint('MESSAGE: ${responseData['message']}');

      if (responseData['success'] != true) {
        throw Exception(
          responseData['message'] ??
              'Failed to fetch vehicle types',
        );
      }

      final data = responseData['data'];

      final List<dynamic> vehicleList;

      if (data is List) {
        vehicleList = data;
      } else if (data is Map &&
          data['vehicle_types'] is List) {
        vehicleList = data['vehicle_types'] as List;
      } else {
        throw const FormatException(
          'Unexpected vehicle types response format',
        );
      }

      final vehicles = vehicleList
          .map(
            (item) => VehiclesTypeModel.fromJson(
              Map<String, dynamic>.from(item as Map),
            ),
          )
          .toList();

      debugPrint('TOTAL VEHICLES: ${vehicles.length}');

      for (final vehicle in vehicles) {
        debugPrint(
          'VEHICLE ID: ${vehicle.id} | NAME: ${vehicle.name}',
        );
      }

      return vehicles;
    } on DioException catch (error) {
      debugPrint(
        'GET VEHICLE TYPES ERROR: ${error.response?.statusCode}',
      );

      final data = error.response?.data;

      if (data is Map) {
        debugPrint('BACKEND MESSAGE: ${data['message']}');
      }

      rethrow;
    }
  }
}