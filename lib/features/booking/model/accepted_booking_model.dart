class AcceptedBookingModel {
  final String bookingId;
  final String pickup;
  final String pickupDistance;

  final String customerName;
  final String customerId;

  final String? customerImage;

  const AcceptedBookingModel({
    required this.bookingId,
    required this.pickup,
    required this.pickupDistance,
    required this.customerName,
    required this.customerId,
    this.customerImage,
  });
}