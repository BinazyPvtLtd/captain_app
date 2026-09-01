class DeliveryRequestModel {
  final String id;

  final String pickup;
  final String drop;
  final String pickupDistance;

  final String tripDistance;
  final String estimatedTime;

  final String earning;

  final String goodsType;
  final String vehicleRequired;

  const DeliveryRequestModel({
    required this.id,
    required this.pickup,
    required this.drop,
    required this.pickupDistance,
    required this.tripDistance,
    required this.estimatedTime,
    required this.earning,
    required this.goodsType,
    required this.vehicleRequired,
  });
}