//Dio 拦截器，重写interceptors
import 'dart:developer';
import 'package:dio/dio.dart';

class PrintLogInterceptor extends InterceptorsWrapper {

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {

      log("\n ▶️requset----------------------------->");
      options.headers.forEach((key, value) {
      log("请求头: key = $key: value = ${value.toString()} ");
      });
      log("path = ${options.uri}");
      log("method = ${options.method}");
      log("data = ${options.data}");
      log("queryParameters = ${options.queryParameters.toString()}");
      log("<-------------------------------request");

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse

    log("\nresponse----------------------------->");
    log("path = ${response.realUri}");
    log("header = ${response.headers.toString()}");
    log("statusMessage = ${response.statusMessage}");
    log("statusCode = ${response.statusCode}");
    log("extra = ${response.extra.toString()}");
    log("data = ${response.data}");
    log("<-------------------------------response\n\n");

    super.onResponse(response, handler);
  }



  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError

    log("\nerror----------------------------->");
    log("path = ${err.requestOptions.path}");
    log("message = ${err.message}");
    log("type = ${err.type}");
    log("error = ${err.error}");
    log("<-------------------------------error\n\n");

    super.onError(err, handler);
  }

}