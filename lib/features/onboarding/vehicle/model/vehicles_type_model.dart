class VehiclesTypeModel {
  final int id;
  final String name;
  final String? imageUrl;

  const VehiclesTypeModel({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  factory VehiclesTypeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VehiclesTypeModel(
      id: (json['id'] as num).toInt(),
      name: (json['name'] ?? '').toString(),
      imageUrl: json['image_url']?.toString(),
    );
  }
}