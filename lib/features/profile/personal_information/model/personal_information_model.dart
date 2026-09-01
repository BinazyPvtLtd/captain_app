class PersonalInformationModel {
  final String name;
  final String mobile;
  final String email;
  final String city;
  final String emergencyContact;
  final String? profileImage;

  const PersonalInformationModel({
    required this.name,
    required this.mobile,
    required this.email,
    required this.city,
    required this.emergencyContact,
    this.profileImage,
  });
}