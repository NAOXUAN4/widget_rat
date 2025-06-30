import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/utils/global.dart';
import 'package:widget_rat/utils/logger.dart';

import '../../api/api.dart';
import '../../api/dataClass/Oss_BaseUrl_data.dart';
import '../../api/dataClass/UsersMe_Res_data.dart';
import 'model.dart';



class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(
    isLoading: false,
    ossAvatarUrl: "",
    loginStatus: false,
    ossUrl: ""
  ));

  Future<dynamic> initUserState() async{
    state = state.CopyWith(isLoading: true);

    // 初始化 OSS 地址
    try  {
      logger.d("初始化 OSS 地址");
      final ossResult = await Api.instance.ossBaseUrl();
      if (ossResult is OssBaseUrlData) {

        ///1.更新state
        state =state.CopyWith(ossUrl: ossResult.ossBaseUrl, ossAvatarUrl: ossResult.ossAvatarUrl);

        ///2.同步->Global
        Global.ossUrl = state.ossUrl;
        Global.ossAvatarUrl = state.ossAvatarUrl;


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
        state = state.CopyWith(userId: userInfo.id, userName: userInfo.username,
            userBio: userInfo.bio, userAvatarPath: userInfo.avatarUrl);

        /// 同步 -> Global数据
        Global.userId = state.userId;
        Global.userName = state.userName;
        Global.userBio = state.userBio;
        Global.userAvatarPath = state.userAvatarPath;


      }

      state = state.CopyWith(loginStatus: true);   /// 登录状态 True
      logger.d("获取用户信息成功, 登录成功！");

    }catch(e) {
      logger.e("获取用户信息失败：${e}， 未登录！");
    }
  }



  Future<dynamic> refreshUserState() async{
    state = state.CopyWith(isLoading: true);

    // 获取用户信息
    try {
      logger.d("获取用户信息");
      final userInfo = await Api.instance.me();
      if(userInfo is UsersMeResData){
        state = state.CopyWith(userId: userInfo.id, userName: userInfo.username,
            userBio: userInfo.bio, userAvatarPath: userInfo.avatarUrl);

        /// 同步 -> Global数据
        Global.userId = state.userId;
        Global.userName = state.userName;
        Global.userBio = state.userBio;
        Global.userAvatarPath = state.userAvatarPath;


      }

      state = state.CopyWith(loginStatus: true);   /// 登录状态 True
      logger.d("获取用户信息成功");

    }catch(e) {
      logger.e("获取用户信息失败：${e}");
    }
  }


  /// 退出登录
  Future<dynamic>userLogout()async{
    state = state.CopyWith(isLoading: true);
    if(Global.isLogin){
      Global.userId = null;
      Global.userName = null;
      Global.userBio = null;
      Global.userAvatarPath = "http//";  //过Network检测
      state = state.CopyWith(
        userId: null,
        userName: null,
        userBio: null,
        userAvatarPath: null,
        loginStatus: false,
        isLoading: false,
      );

      Global.isLogin = false;
    }

    state = state.CopyWith(isLoading: false);
  }

}



final UserNotifierProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);