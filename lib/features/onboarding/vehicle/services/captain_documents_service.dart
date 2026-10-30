import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_config.dart';

class CaptainDocumentsService {
  final Dio _dio = ApiClient().dio;

  // GET: Fetch captain documents
  Future<dynamic> getDocuments() async {
    try {
      final response = await _dio.get(
        ApiConfig.captainDocuments,
      );

      return response.data;
    } 
    on DioException catch (e) {
  debugPrint('========== DOCUMENT UPLOAD API ERROR ==========');

  debugPrint('API URL: ${e.requestOptions.uri}');
  debugPrint('METHOD: ${e.requestOptions.method}');
  debugPrint('STATUS CODE: ${e.response?.statusCode}');
  debugPrint('ERROR TYPE: ${e.type}');
  debugPrint('ERROR MESSAGE: ${e.response?.data ?? e.message}');

  debugPrint('================================================');

  rethrow;
}
  }

  // POST: Upload document using multipart
  Future<dynamic> uploadDocument({
    required String documentType,
    required String filePath,
    required String fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),

        'file_name': fileName,
      });

      final response = await _dio.post(
        ApiConfig.uploadCaptainDocument(documentType),
        data: formData,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
        ),
        onSendProgress: (sent, total) {
          if (total > 0) {
            final progress = (sent / total * 100).round();

            // No sensitive file contents logged.
            print('Document upload progress: $progress%');
          }
        },
      );

      return response.data;
    } on DioException catch (e) {
      print('DOCUMENT UPLOAD STATUS: ${e.response?.statusCode}');
      print('DOCUMENT UPLOAD ERROR: ${e.response?.data}');

      throw Exception(
        e.response?.data ?? e.message,
      );
    }
  }
}