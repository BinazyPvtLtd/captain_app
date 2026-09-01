class TripDetailsModel {
  final String bookingId;

  final String pickup;
  final String dropoff;

  final String estimatedDistance;
  final String estimatedTime;

  final String goodsType;
  final String quantity;

  final String customerName;
  final String? customerImage;
  final String? customerPhone;

  const TripDetailsModel({
    required this.bookingId,
    required this.pickup,
    required this.dropoff,
    required this.estimatedDistance,
    required this.estimatedTime,
    required this.goodsType,
    required this.quantity,
    required this.customerName,
    this.customerImage,
    this.customerPhone,
  });
}