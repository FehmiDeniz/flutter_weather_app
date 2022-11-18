import 'package:dio/dio.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("REQUEST ${options.method} ==> ${options.path}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("RESPONSE ${response.statusCode} ==> ${response.requestOptions}");
    return super.onResponse(response, handler);
  }
}
