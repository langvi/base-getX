import 'package:dio/dio.dart';

class CustomInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("OnRequest....");
    print("Method: ${options.method}");
    print("Path: ${options.uri}");
    super.onRequest(options, handler);
    print("Body: ${options.data}");
  }
}