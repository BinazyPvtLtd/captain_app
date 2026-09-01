class DriverProfileModel {
  final String name;
  final String driverId;
  final double rating;
  final String? profileImage;

  const DriverProfileModel({
    required this.name,
    required this.driverId,
    required this.rating,
    this.profileImage,
  });
}