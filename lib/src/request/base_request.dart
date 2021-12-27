import 'package:base_getx/base_getx.dart' as BaseGet;
import 'package:base_getx/src/const/config.dart';
import 'package:base_getx/src/const/storage.dart';
import 'package:base_getx/src/request/abstract_request.dart';
import 'package:dio/dio.dart';

class BaseRequestImpl extends BaseRequest {
  static Dio dio = Dio();
  static final _singleton = BaseRequestImpl._internal();
  int _numberOfDialog = 0;

  factory BaseRequestImpl({required String baseUrl}) {
    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.baseUrl = baseUrl;
    return _singleton;
  }

  BaseRequestImpl._internal();

  @override
  Future<Map<String, dynamic>> getBaseHeader() async {
    final String token = await StorageApp.getTokenAuthen();
    Map<String, String> map = {
      'Authorization': 'Bearer $token',
    };
    return map;
  }

  @override
  Future<dynamic> sendRequest(
      {required String path,
      required RequestMethod requestMethod,
      body,
      param,
      bool sendHeader = true,
      bool isHandleError = true,
      void Function(int, int)? onProgress}) async {
    Response? response;
    try {
      if (requestMethod == RequestMethod.GET) {
        response = await dio.get(
          path,
          queryParameters: param,
          onReceiveProgress: onProgress,
          options: Options(headers: sendHeader ? await getBaseHeader() : null),
        );
      } else if (requestMethod == RequestMethod.POST) {
        response = await dio.post(
          path,
          queryParameters: param,
          data: body,
          onReceiveProgress: onProgress,
          options: Options(headers: sendHeader ? await getBaseHeader() : null),
        );
      } else if (requestMethod == RequestMethod.PUT) {
        response = await dio.put(
          path,
          queryParameters: param,
          data: body,
          onReceiveProgress: onProgress,
          options: Options(headers: sendHeader ? await getBaseHeader() : null),
        );
      } else {
        response = await dio.delete(
          path,
          queryParameters: param,
          data: body,
          options: Options(headers: sendHeader ? await getBaseHeader() : null),
        );
      }
    } catch (err) {
      print(err);
      if (err is DioError && isHandleError) {
        handleDioError(err);
      }
      return null;
    }
    return response.data;
  }

  @override
  void showError(String error, int statusCode) async {
    if (_numberOfDialog == 0) {
      await BaseGet.ShowDialog()
          .showErrorDialog(title: "Thong bao", content: error);
      _numberOfDialog++;
    } else {
      // reset value
      _numberOfDialog = 0;
    }
  }

  @override
  void handleDioError(DioError dioError) {
    int statusCode = 0;
    String content = '';
    if (dioError.response != null) {
      statusCode = dioError.response!.statusCode ?? 0;
      switch (dioError.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          content =
              'Không có phản hồi từ hệ thống, Quý khách vui lòng thử lại sau';
          break;
        case DioErrorType.response:
          switch (statusCode) {
            case 400:
              content = 'Dữ liệu gửi đi không hợp lệ!';
              break;
            case 401:
              content =
                  'Phiên đăng nhập đã hết hạn, quý khách vui lòng đăng nhập lại';
              break;
            case 404:
              content =
                  'Không tìm thấy đường dẫn này, xin vui lòng liên hệ Admin';
              break;
            case 500:
              content = 'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
              break;

            default:
              content = 'Lỗi xử lý hệ thống\nXin vui lòng thử lại sau!!!';
          }
          break;
        default:
          content =
              'Không thể kết nối tới máy chủ\nQuý khách vui lòng kiểm tra lại kết nối mạng';
      }
    }
    showError(content, statusCode);
  }
}
