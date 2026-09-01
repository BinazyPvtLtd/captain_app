class PickupNavigationModel {
  final String bookingId;
  final String eta;
  final String distance;

  final String pickupAddress;

  final String customerName;
  final String? customerPhone;

  const PickupNavigationModel({
    required this.bookingId,
    required this.eta,
    required this.distance,
    required this.pickupAddress,
    required this.customerName,
    this.customerPhone,
  });
}