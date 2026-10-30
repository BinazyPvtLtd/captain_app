import 'package:dio/dio.dart';
import 'package:driver_app/features/onboarding/vehicle/services/captain_vehicle_service.dart';
import 'package:flutter/material.dart';


class VehicleDetailsViewModel extends ChangeNotifier {

   final int vehicleTypeId;
  final String vehicleTypeName;

  VehicleDetailsViewModel({
    required this.vehicleTypeId,
    required this.vehicleTypeName,
  });


  final CaptainVehicleService _vehicleService =
    CaptainVehicleService();
  // =========================================================
  // CONTROLLERS
  // =========================================================

  final TextEditingController vehicleNumberController =
      TextEditingController();

  final TextEditingController vehicleColorController =
      TextEditingController();

  final TextEditingController manufacturingYearController =
      TextEditingController();

  // =========================================================
  // VEHICLE TYPES
  // =========================================================

  // static const List<VehicleTypeModel> vehicleTypes = [
  //   VehicleTypeModel(
  //     id: 'two_wheeler',
  //     title: '2 Wheeler',
  //     icon: Icons.two_wheeler_rounded,
  //   ),
  //   VehicleTypeModel(
  //     id: 'three_wheeler',
  //     title: '3 Wheeler',
  //     icon: Icons.electric_rickshaw_rounded,
  //   ),
  //   VehicleTypeModel(
  //     id: 'mini_truck',
  //     title: 'Mini Truck',
  //     icon: Icons.local_shipping_outlined,
  //   ),
  //   VehicleTypeModel(
  //     id: 'pickup_truck',
  //     title: 'Pickup Truck',
  //     icon: Icons.fire_truck_outlined,
  //   ),
  // ];

  // VehicleTypeModel? _selectedVehicleType =
  //     vehicleTypes.first;

  // VehicleTypeModel? get selectedVehicleType =>
  //     _selectedVehicleType;

  // =========================================================
  // BRAND
  // =========================================================

  static const List<String> brands = [
    'Tata',
    'Mahindra',
    'Ashok Leyland',
    'Maruti Suzuki',
    'Bajaj',
    'TVS',
    'Other',
  ];

  String? _selectedBrand;

  String? get selectedBrand => _selectedBrand;

  // =========================================================
  // MODEL
  // =========================================================

  static const List<String> models = [
    'Ace',
    'Super Ace',
    'Jeeto',
    'Dost',
    'Pickup',
    'Other',
  ];

  String? _selectedModel;

  String? get selectedModel => _selectedModel;

  // =========================================================
  // LOADING
  // =========================================================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // =========================================================
  // SELECT VEHICLE TYPE
  // =========================================================

  // void selectVehicleType(
  //   VehicleTypeModel vehicle,
  // ) {
  //   _selectedVehicleType = vehicle;

  //   notifyListeners();
  // }

  // =========================================================
  // BRAND
  // =========================================================

  void selectBrand(
    String? value,
  ) {
    _selectedBrand = value;

    _selectedModel = null;

    notifyListeners();
  }

  // =========================================================
  // MODEL
  // =========================================================

  void selectModel(
    String? value,
  ) {
    _selectedModel = value;

    notifyListeners();
  }

  // =========================================================
  // VALIDATION
  // =========================================================

  bool validate(
    BuildContext context,
  ) {
    final String vehicleNumber =
        vehicleNumberController.text.trim();

    final String vehicleColor =
        vehicleColorController.text.trim();

   

    if (vehicleNumber.isEmpty) {
      _showMessage(
        context,
        'Please enter your vehicle number.',
      );

      return false;
    }

    if (_selectedBrand == null) {
      _showMessage(
        context,
        'Please select your vehicle brand.',
      );

      return false;
    }

    if (_selectedModel == null) {
      _showMessage(
        context,
        'Please select your vehicle model.',
      );

      return false;
    }

    // if (vehicleColor.isEmpty) {
    //   _showMessage(
    //     context,
    //     'Please enter your vehicle color.',
    //   );

    //   return false;
    // }

    return true;
  }

  // =========================================================
  // CONTINUE
  // =========================================================

  Future<void> continueVehicle(
  BuildContext context, {
  required Future<void> Function() onSuccess,
}) async {
  if (_isLoading) return;

  FocusScope.of(context).unfocus();

  if (!validate(context)) {
    return;
  }

  _setLoading(true);

  try {
    final registrationNumber =
        vehicleNumberController.text.trim().toUpperCase();

    final response = await _vehicleService.createVehicle(
      vehicleTypeId: vehicleTypeId,
      registrationNumber: registrationNumber,
      make: _selectedBrand!,
      model: _selectedModel!,
    );

    if (!context.mounted) return;

    if (response['success'] == true) {
      debugPrint('Captain vehicle created successfully');

      await onSuccess();
    } else {
      _showMessage(
        context,
        response['message']?.toString() ??
            'Unable to create vehicle',
      );
    }
  } on DioException catch (error) {
    if (!context.mounted) return;

    final data = error.response?.data;

    String message = 'Unable to create vehicle';

    if (data is Map && data['message'] != null) {
      message = data['message'].toString();
    }

    debugPrint('CREATE VEHICLE ERROR: $message');

    _showMessage(context, message);
  } catch (error) {
    debugPrint('CREATE VEHICLE ERROR: $error');

    if (!context.mounted) return;

    _showMessage(
      context,
      'Something went wrong. Please try again.',
    );
  } finally {
    _setLoading(false);
  }
}

  // =========================================================
  // LOADING
  // =========================================================

  void _setLoading(
    bool value,
  ) {
    _isLoading = value;

    notifyListeners();
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    vehicleNumberController.dispose();
    vehicleColorController.dispose();
    manufacturingYearController.dispose();

    super.dispose();
  }
}