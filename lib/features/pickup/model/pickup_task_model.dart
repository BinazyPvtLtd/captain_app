class PickupTaskModel {
  final String bookingId;
  final String pickupLocation;
  final String customerName;
  final String? customerPhone;

  const PickupTaskModel({
    required this.bookingId,
    required this.pickupLocation,
    required this.customerName,
    this.customerPhone,
  });
}