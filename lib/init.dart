import 'package:dio/dio.dart';
import 'package:widget_rat/utils/constants.dart';
import 'package:widget_rat/utils/global.dart';
import 'package:widget_rat/utils/logger.dart';
import 'api/api.dart';
import 'api/dataClass/Oss_BaseUrl_data.dart';
import 'api/dataClass/UsersMe_Res_data.dart';
import 'http/dio_instance.dart';


Future<void> initializeApp() async {

  DioInstance.instance().initDio(baseUrl: Constants.baseUrl);

  // 初始化 OSS 地址
  try  {
    logger.d("初始化 OSS 地址");
    final ossResult = await Api.instance.ossBaseUrl();
    if (ossResult is OssBaseUrlData) {
      Global.ossUrl = ossResult.ossBaseUrl;
      Global.ossAvatarUrl = ossResult.ossAvatarUrl;
    }
    logger.d("初始化 OSS 地址成功");
  } catch (e) {
    logger.e("初始化OSS地址失败：${e}");
  }

  // 获取用户信息
  try {
    logger.d("获取用户信息");
    final userInfo = await Api.instance.me();
    if(userInfo is UsersMeResData){
      Global.userId = userInfo.id;
      Global.userName = userInfo.username;
      Global.userBio = userInfo.bio;
    }

    Global.isLogin  = true;   /// 登录状态 True
    logger.d("获取用户信息成功");

  }catch(e) {
    logger.e("获取用户信息失败：${e}");
  }


}
