class DeliveryCompletedModel {
  final String bookingId;

  final String pickup;
  final String dropoff;

  final String distance;
  final String time;

  final String earning;
  final String paymentStatus;

  const DeliveryCompletedModel({
    required this.bookingId,
    required this.pickup,
    required this.dropoff,
    required this.distance,
    required this.time,
    required this.earning,
    required this.paymentStatus,
  });
}