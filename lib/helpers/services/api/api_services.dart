import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:itunes/config/api_path.dart';
import 'package:itunes/helpers/common_helpers.dart';
import 'package:itunes/helpers/services/api/api_exceptions.dart';

class RestAPIService {
  final Dio _dio;

  RestAPIService(this._dio);

  getCertificates() async {
    final certificates =
        await rootBundle.load('assets/certificates/www.apple.com.pem');
    final dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final securityContext = SecurityContext();
      securityContext
          .setTrustedCertificatesBytes(certificates.buffer.asUint8List());
      return HttpClient(context: securityContext);
    };
  }

  Future<dynamic> postService({
    required String url,
    required FormData body,
  }) async {
    String fetchUrl;
    try {
      await getCertificates();
      fetchUrl = ITunesAPI.baseUrl + url;
      showLog("URL ====>>>>>> POST : $fetchUrl");
      showLog("BODY ====>>>>>>$body");

      var response = await _dio.post(
        fetchUrl,
        data: body,
      );
      showLog("RESPONSE ====>>>>>>${response.data}");
      return response.data;
    } on DioException catch (e) {
      showLog("error is : ${e.response}");
      throw RestAPIException.fromDioError(e);
    }
  }

  getService({
    required String url,
  }) async {
    String fetchUrl;
    try {
      await getCertificates();

      fetchUrl = ITunesAPI.baseUrl + url;

      showLog("URL ====>>>>>> GET : $fetchUrl");
      var response = await _dio.get(fetchUrl);
      //showLog("RESPONSE ====>>>>>>${response.data}");
      return response.data;
    } on DioException catch (dioError) {
      showLog(dioError.message!);
      throw RestAPIException.fromDioError(dioError);
    }
  }
}
