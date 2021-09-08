import 'package:base_getx/base_getx.dart';
import 'package:dio/dio.dart';
import 'package:example/main.dart';

class HandleException extends BaseHandleException{
  static final instance = HandleException._private();
  HandleException._private();
  @override
  void handleExceptionAsync(DioError error, StackTrace stackTrace) {
    int statusCode = 0;
    String errorContent = 'Không thể kết nối tới máy chủ\nQuý khách vui lòng kiểm tra lại kết nối mạng';
    if (error.response != null) {
      switch (error.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          statusCode = error.response!.statusCode ?? 0;
          errorContent = 'Không có phản hồi từ hệ thống, Quý khách vui lòng thử lại sau';
          break;
        case DioErrorType.response:
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
    onErrorCallBackApp(errorContent, statusCode);
  }
}