import 'package:flutter/material.dart';

import '../model/vehicle_details_model.dart';

class VehicleDetailsViewModel
    extends ChangeNotifier {
  VehicleDetailsViewModel({
    VehicleDetailsModel? vehicle,
  }) : _vehicle = vehicle ??
            const VehicleDetailsModel(
              vehicleType: 'Mini Truck',
              brand: 'Tata Ace',
              plateNumber: 'UP32 AB 1234',
              color: 'White',
              documents: [
                VehicleDocumentModel(
                  title: 'RC',
                  isApproved: true,
                ),
                VehicleDocumentModel(
                  title: 'Insurance',
                  isApproved: true,
                ),
                VehicleDocumentModel(
                  title: 'Pollution',
                  isApproved: true,
                ),
                VehicleDocumentModel(
                  title: 'Permit',
                  isApproved: true,
                ),
              ],
            );

  final VehicleDetailsModel _vehicle;

  VehicleDetailsModel get vehicle =>
      _vehicle;

  // =========================================================
  // UPDATE VEHICLE
  // =========================================================

  void updateVehicle({
    required VoidCallback onPressed,
  }) {
    onPressed();
  }

  // =========================================================
  // OPEN DOCUMENT
  // =========================================================

  void openDocument({
    required VehicleDocumentModel document,
    required VoidCallback onPressed,
  }) {
    onPressed();
  }
}