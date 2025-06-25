import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/providers/UserProvider/viewmodel.dart';
import 'package:widget_rat/utils/constants.dart';
import 'package:widget_rat/utils/global.dart';
import 'package:widget_rat/utils/logger.dart';
import 'api/api.dart';
import 'api/dataClass/Oss_BaseUrl_data.dart';
import 'api/dataClass/UsersMe_Res_data.dart';
import 'http/dio_instance.dart';


Future<void> initAsync(WidgetRef ref) async {

  final UserViewModel = ref.watch(UserNotifierProvider);

  /// 1 .初始化 UserProvider (ossPath / userMeInfo / isLogin )
  await ref.read(UserNotifierProvider.notifier).initUserState();



}

void initSync(){

}
