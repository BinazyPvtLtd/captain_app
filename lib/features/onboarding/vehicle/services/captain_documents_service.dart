import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';

class CaptainDocumentsService {
  final Dio _dio = ApiClient().dio;

  // =====================================================
  // GET CAPTAIN DOCUMENTS
  // =====================================================

  Future<dynamic> getDocuments() async {
    try {
      final response = await _dio.get(
        ApiConfig.captainDocuments,
      );

      return response.data;
    } on DioException catch (error) {
      throw Exception(
        error.response?.data ?? error.message,
      );
    }
  }

  // =====================================================
  // POST CAPTAIN DOCUMENT
  // =====================================================

  Future<dynamic> uploadDocument({
    required String documentType,
    required String fileUrl,
  }) async {
    try {
      final response = await _dio.post(
        ApiConfig.uploadCaptainDocument(documentType),
        data: {
          'file_url': fileUrl,
        },
      );

      return response.data;
    } on DioException catch (error) {
      throw Exception(
        error.response?.data ?? error.message,
      );
    }
  }
}