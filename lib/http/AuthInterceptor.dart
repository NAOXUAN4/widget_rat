import 'dart:io';

import 'package:dio/dio.dart';
import '../utils/constants.dart';
import '../utils/sp_utils.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio = Dio();

  // 请求拦截：添加 Cookie
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    SpUtils.getStringList(Constants.SP_Cookie_List).then((cookies) {
      if (cookies != null && cookies.isNotEmpty) {
        options.headers[HttpHeaders.cookieHeader] = cookies;
      }
      handler.next(options);
    }).catchError((e) {
      handler.next(options);
    });
  }

  // 响应拦截：保存 Cookie（登录和刷新接口）
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final String path = response.requestOptions.path;

    if (path.contains("user/login") || path.contains("token/refresh")) {
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookieList = [];

      if (list is List) {
        for (String item in list) {
          cookieList.add(item);
        }
      }

      if (cookieList.isNotEmpty) {
        SpUtils.saveStringList(Constants.SP_Cookie_List, cookieList);
      }
    }

    handler.next(response);
  }

  // 错误拦截：处理 401 并尝试刷新 Token
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final String? refreshToken = await _getRefreshTokenFromCookies();
        if (refreshToken == null) {
          return handler.reject(err);
        }

        // 调用刷新 Token 接口
        final Response refreshResponse = await _dio.post(
          "${Constants.baseUrl}/api/token/refresh/",
          data: {"refresh": refreshToken},
        );

        if (refreshResponse.statusCode == 200) {
          // 提取新的 Set-Cookie 并更新本地存储
          final dynamic newCookies = refreshResponse.headers[HttpHeaders.setCookieHeader];
          if (newCookies is List) {
            SpUtils.saveStringList(Constants.SP_Cookie_List, newCookies.cast<String>());
          }

          // 重新发起原始请求
          final RequestOptions originalOptions = err.requestOptions;
          final Response retryResponse = await _dio.fetch(originalOptions);
          handler.resolve(retryResponse);
        } else {
          handler.reject(DioError(requestOptions: err.requestOptions, error: "Token refresh failed"));
        }
      } catch (e) {
        handler.reject(DioError(requestOptions: err.requestOptions, error: e));
      }
    } else {
      handler.reject(err);
    }
  }

  // 从本地 Cookie 中提取 refresh token
  Future<String?> _getRefreshTokenFromCookies() async {
    List<String>? cookies = await SpUtils.getStringList(Constants.SP_Cookie_List);
    if (cookies == null) return null;

    for (var cookie in cookies) {
      if (cookie.contains("refresh_token=")) {
        var parts = cookie.split(";");
        for (var part in parts) {
          if (part.contains("refresh_token=")) {
            return part.split("=")[1];
          }
        }
      }
    }
    return null;
  }
}
