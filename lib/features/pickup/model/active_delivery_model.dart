class ActiveDeliveryModel {
  final String bookingId;

  final String destination;
  final String distance;
  final String eta;

  final String customerName;
  final String customerId;
  final String? customerImage;
  final String? customerPhone;

  const ActiveDeliveryModel({
    required this.bookingId,
    required this.destination,
    required this.distance,
    required this.eta,
    required this.customerName,
    required this.customerId,
    this.customerImage,
    this.customerPhone,
  });
}