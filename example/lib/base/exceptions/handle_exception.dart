import 'package:base_getx/base_getx.dart';
import 'package:dio/dio.dart';
import 'package:example/main.dart';

class HandleException extends BaseHandleException {
  static final instance = HandleException._private();

  HandleException._private();

  @override
  void handleExceptionAsync(Object error, StackTrace stackTrace) {
    int statusCode = 0;
    String errorContent = 'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
    if (error is DioException) {
      if (error.response != null) {
        statusCode = error.response!.statusCode ?? 0;
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            errorContent = 'Không có phản hồi từ hệ thống, Quý khách vui lòng thử lại sau';
            break;
          case DioExceptionType.badResponse:
            switch (statusCode) {
              case 400:
                errorContent = 'Dữ liệu gửi đi không hợp lệ!';
                break;
              case 401:
                errorContent = 'Phiên đăng nhập đã hết hạn, quý khách vui lòng đăng nhập lại';
                break;
              case 404:
                errorContent = 'Không tìm thấy đường dẫn này, xin vui lòng liên hệ Admin';
                break;
              default:
                errorContent = 'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
            }
            break;
          default:
            errorContent = 'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
        }
      }
    }

    onErrorCallBackApp(errorContent, statusCode);
  }
}
