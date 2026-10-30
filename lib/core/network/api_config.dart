class ApiConfig {
  static const String baseUrl =
      'https://api.patgolito.com/api/v1';

  static const String sendOtp = '/auth/send-otp';

  static const String verifyOtp = '/auth/verify-otp';

  static const String currentUser = '/auth/me';

  static const String logout = '/auth/logout';

  static const String vehicleTypes = '/vehicle-types';

  static const String captainOnboardingApply =
    '/captain/onboarding/apply';

    static const String createCaptainVehicle = '/captain/vehicles';


    static const String captainDocuments = '/captain/documents';


static String uploadCaptainDocument(String documentType) {
  return '/captain/documents/${Uri.encodeComponent(documentType)}';
}
}