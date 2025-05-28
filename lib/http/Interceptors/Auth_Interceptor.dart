import 'dart:io';

import 'package:dio/dio.dart';
import '../../utils/constants.dart';
import '../../utils/logger.dart';
import '../../utils/sp_utils.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio = Dio();

  // 请求拦截：添加 Cookie
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      List<String>? cookies = await SpUtils.getStringList(Constants.SP_Cookie_List);
      if (cookies != null && cookies.isNotEmpty) {
        options.headers[HttpHeaders.cookieHeader] = cookies.join("; ");
      }
    } catch (e) {
      // 忽略错误或打印日志
    }
    // 确保 cookie 设置完成后再继续发送请求
    handler.next(options);
  }


  // 响应拦截：保存 Cookie（登录和刷新接口）
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final String path = response.requestOptions.path;

    if (path.contains("users/login")){
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookieList = [];

      if (list is List) {
        for (String item in list) {
          // logger.d("Cookie: $item");
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
      logger.e("Token 验证失败，正在尝试刷新 Token...");
      try {
        final String? refreshToken = await _getRefreshTokenFromCookies();
        if (refreshToken == null) {
          logger.e("未在本地找到 refresh token");
          return handler.reject(err);
        }

        // 调用刷新 Token 接口
        final Response refreshResponse = await _dio.post(
          "${Constants.baseUrl}/api/token/refresh/",
          data: {"refresh": refreshToken},
        );


        if (refreshResponse.statusCode == 200) {
          // 提取新的 Set-Cookie 并更新本地存储
          final dynamic newAccessKey = refreshResponse.headers[HttpHeaders.setCookieHeader];
          if (newAccessKey is List) {
            // 替换本地 Cookie 中的 access_token
            List<String>? existingCookies = await SpUtils.getStringList(Constants.SP_Cookie_List);
            if (existingCookies == null) existingCookies = [];
            // logger.d("existingCookiesBefore: $existingCookies");

            existingCookies.removeWhere((cookie) => cookie.contains("access_token="));
            existingCookies.add(newAccessKey[0] as String);   /// 替换旧 access_token
            // logger.d("existingCookiesAfter: $existingCookies");
            await SpUtils.saveStringList(Constants.SP_Cookie_List, existingCookies);

          }

          // 重新发起原始请求
          try{
            // ✅ 更新请求头中的 Cookie
            final RequestOptions originalOptions = err.requestOptions;
            List<String>? updatedCookies = await SpUtils.getStringList(Constants.SP_Cookie_List);
            if (updatedCookies != null && updatedCookies.isNotEmpty) {
              originalOptions.headers[HttpHeaders.cookieHeader] = updatedCookies.join("; ");
            }

            // ✅ 重新发起原始请求
            final Response retryResponse = await _dio.fetch(originalOptions);
            logger.d("Token 刷新成功，正在重新发起请求...");
            logger.d("重试请求完成，状态码: ${retryResponse.statusCode}");
            logger.d("重试请求响应体: ${retryResponse.data}");
            handler.resolve(retryResponse);


          }catch(e){
            logger.e("重新发起请求失败：$e");
          }


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
    // logger.d(cookies);
    if (cookies == null) {
      // logger.e("未在本地找到 Cookie");
      return null;
    }

    for (var cookie in cookies) {
      if (cookie.contains("refresh_token=")) {
        var parts = cookie.split(";")[0]; // 取第一个部分
        parts = parts.split("=")[1];
        // logger.d("refresh_token: $parts");
        return parts;
      }
    }
    return null;
  }
}
