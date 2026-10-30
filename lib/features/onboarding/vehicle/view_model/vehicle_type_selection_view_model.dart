import 'package:flutter/material.dart';

import '../model/vehicles_type_model.dart';
import '../services/vehicle_type_service.dart';

import '../../services/captain_onboarding_service.dart';

class VehicleTypeSelectionViewModel extends ChangeNotifier {
  final VehicleTypeService _vehicleService =
      VehicleTypeService();

  final CaptainOnboardingService _onboardingService =
      CaptainOnboardingService();

  List<VehiclesTypeModel> _vehicles = [];

  int? _selectedVehicleId;

  bool _isLoading = false;
  bool _isSubmitting = false;

  String? _errorMessage;

  List<VehiclesTypeModel> get vehicles => _vehicles;

  int? get selectedVehicleId => _selectedVehicleId;

  bool get isLoading => _isLoading;

  bool get isSubmitting => _isSubmitting;

  String? get errorMessage => _errorMessage;

  bool get canSubmit =>
      _selectedVehicleId != null && !_isSubmitting;

  // GET VEHICLE TYPES
  Future<void> fetchVehicleTypes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _vehicles = await _vehicleService.getVehicleTypes();
    } catch (error) {
      _errorMessage = 'Unable to load vehicle types';
      debugPrint('Vehicle fetch failed: ${error.runtimeType}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // SELECT VEHICLE
  void selectVehicle(int vehicleId) {
    if (_isSubmitting) return;

    _selectedVehicleId = vehicleId;
    notifyListeners();
  }

  // APPLY FOR CAPTAIN
  Future<bool> submitSelection() async {
    if (!canSubmit) return false;

    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _onboardingService.applyForCaptain(
        vehicleTypeId: _selectedVehicleId!,
      );

      return true;
    } catch (error) {
      _errorMessage = 'Unable to submit application';
      debugPrint('Application failed: ${error.runtimeType}');
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}