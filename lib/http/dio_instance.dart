//封装dio实例
import 'package:dio/dio.dart';
import 'package:widget_rat/http/Interceptors/print_log_interceptor.dart';
import 'Interceptors/Auth_Interceptor.dart';
import 'http_methods.dart';



class DioInstance{
  static DioInstance ? _instance;
  DioInstance._();

  static DioInstance instance(){
    _instance ??= DioInstance._();
    return _instance!;
  }

  final Dio _dio = Dio();
  final _defualtTime = const Duration(seconds: 30);

  void initDio({
    String? httpMeethod =  HttpMethods.GET,
    required String baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    ResponseType? responseType,
    String? contentType,
  }){
    _dio.options = BaseOptions(
      method: httpMeethod,
      baseUrl: baseUrl,
      connectTimeout: connectTimeout ?? _defualtTime,
      receiveTimeout: receiveTimeout ?? _defualtTime,
      responseType: responseType ?? ResponseType.json,
      contentType: contentType ?? Headers.formUrlEncodedContentType,
    );
    _dio.interceptors.add(AuthInterceptor());   //先添加cookie拦截器，防止后面拦截器污染
    _dio.interceptors.add(PrintLogInterceptor());
    // _dio.interceptors.add(ResponseInterceptor());

  }

  //封装get请求
  Future<Response>get({
    required String path,
    Map<String,dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
  }) async{
    return await _dio.get(path,queryParameters: param,
      options: options ?? Options(
          method: HttpMethods.GET,
          receiveTimeout: _defualtTime,
          sendTimeout: _defualtTime),
      cancelToken: cancelToken,);
    }


  //封装post请求
  Future<Response>post({
    required String path,
    Object? data,
    Map<String,dynamic>? queryParam,
    Options? options,
    CancelToken? cancelToken,
  }) async{
    return await _dio.post(path,queryParameters: queryParam,
      data: data,
      options: options ?? Options(
          method: HttpMethods.POST,
          receiveTimeout: _defualtTime,
          sendTimeout: _defualtTime),
      cancelToken: cancelToken,);
  }

  // 封装 PUT 请求
  Future<Response> put({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParam,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.put(path,
      queryParameters: queryParam,
      data: data,
      options: options ?? Options(
          method: HttpMethods.PUT,
          receiveTimeout: _defualtTime,
          sendTimeout: _defualtTime),
      cancelToken: cancelToken,
    );
  }





}
