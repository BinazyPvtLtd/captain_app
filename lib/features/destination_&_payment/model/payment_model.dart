enum PaymentMethod {
  online,
  cash,
}

class PaymentModel {
  final String bookingId;

  final double totalFare;
  final double baseFare;
  final double serviceCharge;

  final String pickup;
  final String dropoff;

  final String distance;
  final String time;

  final String? qrImage;

  const PaymentModel({
    required this.bookingId,
    required this.totalFare,
    required this.baseFare,
    required this.serviceCharge,
    required this.pickup,
    required this.dropoff,
    required this.distance,
    required this.time,
    this.qrImage,
  });
}