import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:oktoast/oktoast.dart';
import 'package:widget_rat/router/routes.dart';
import 'package:widget_rat/common/style/theme.dart';
import 'package:widget_rat/themeviewmodel.dart';
import 'package:widget_rat/utils/constants.dart';
import 'package:widget_rat/utils/global.dart';
import 'package:widget_rat/utils/logger.dart';

import 'api/api.dart';
import 'api/dataClass/Oss_BaseUrl_data.dart';
import 'http/dio_instance.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(  //设置状态栏透明
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  try  {
    DioInstance.instance().initDio(baseUrl: Constants.baseUrl);
    final ossResult = await Api.instance.ossBaseUrl();
    if (ossResult is OssBaseUrlData) {
      Global.ossUrl = ossResult.ossBaseUrl;
      Global.ossAvatarUrl = ossResult.ossAvatarUrl;
    }
  } catch (e) {
    print(e);
  }


  runApp(ProviderScope(child: const MyApp()));     // ProviderScope 包裹
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,  WidgetRef ref ) {
    final ThemeModeState = ref.watch(themeModeNotifierProvider);
    // Global.init().then((value) {
    //   print("初始化完成");
    // });
    return OKToast(
      child: ScreenUtilInit(
        builder: (context, child) {
          return MaterialApp.router(
            title: "WidgetRat",
            routerConfig: approutes,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeModeState.isNight ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}
