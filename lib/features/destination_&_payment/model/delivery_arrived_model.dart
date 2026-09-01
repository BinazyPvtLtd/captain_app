class DeliveryArrivedModel {
  final String bookingId;
  final String destination;

  final String customerName;
  final String customerRole;
  final String? customerImage;
  final String? customerPhone;

  const DeliveryArrivedModel({
    required this.bookingId,
    required this.destination,
    required this.customerName,
    this.customerRole = 'Recipient',
    this.customerImage,
    this.customerPhone,
  });
}