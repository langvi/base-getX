import 'package:dio/dio.dart';

enum RequestMethod { GET, POST, PUT, DELETE }

abstract class BaseRequest {
  Future<dynamic> sendRequest(
      {required String path,
      required RequestMethod requestMethod,
      dynamic body,
      dynamic param,
      bool sendHeader = true,
      bool isHandleError = true,
      void Function(int, int)? onProgress});

  Future<Map<String, dynamic>> getBaseHeader();

  /// Hiển thị thông báo lỗi khi request xảy ra exception như timeout, request error, response error...
  void showError(String error, int statusCode);

  void handleDioError(DioError dioError);
}
