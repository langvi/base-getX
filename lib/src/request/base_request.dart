import 'package:base_getx/src/const/config.dart';
import 'package:base_getx/src/const/storage.dart';
import 'package:base_getx/src/request/abstract_request.dart';
import 'package:dio/dio.dart';

class BaseRequest extends AbstractRequest {
  static Dio dio = Dio();
  static final _singleton = BaseRequest._internal();

  factory BaseRequest({required String baseUrl}) {
    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.baseUrl = baseUrl;
    return _singleton;
  }

  BaseRequest._internal();

  @override
  Future<dynamic> sendGetRequest(String path, {dynamic queryParams, bool sendHeader = true}) async {
    late Response response;
    response = await dio.get(
      path,
      queryParameters: queryParams,
      options: Options(headers: sendHeader ? await getBaseHeader() : null),
    );
    return response.data;
  }

  @override
  Future<dynamic> sendPostRequest(String path,
      {dynamic body, Map<String, dynamic>? param, bool sendHeader = true}) async {
    late Response response;
    response = await dio.post(
      path,
      data: body,
      queryParameters: param,
      options: Options(
        headers: sendHeader ? await getBaseHeader() : null,
      ),
    );
    return response.data;
  }

  @override
  Future<dynamic> sendPutRequest(String path, {Map<String, dynamic>? body, Map<String, dynamic>? param}) async {
    late Response response;
    response =
        await dio.put(path, queryParameters: param, data: body, options: Options(headers: await getBaseHeader()));
    return response.data;
  }

  @override
  Future<dynamic> sendDeleteRequest(String path, {Map<String, dynamic>? queryParams}) async {
    late Response response;
    response = await dio.delete(path, queryParameters: queryParams, options: Options(headers: await getBaseHeader()));
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getBaseHeader() async {
    final String token = await StorageApp.getTokenAuthen();
    Map<String, String> map = {
      'Authorization': 'Bearer $token',
    };
    return map;
  }
}
