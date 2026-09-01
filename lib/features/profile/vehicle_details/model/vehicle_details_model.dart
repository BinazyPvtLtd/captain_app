class VehicleDocumentModel {
  final String title;
  final bool isApproved;

  const VehicleDocumentModel({
    required this.title,
    required this.isApproved,
  });
}

class VehicleDetailsModel {
  final String vehicleType;
  final String brand;
  final String plateNumber;
  final String color;

  final List<VehicleDocumentModel> documents;

  const VehicleDetailsModel({
    required this.vehicleType,
    required this.brand,
    required this.plateNumber,
    required this.color,
    required this.documents,
  });
}