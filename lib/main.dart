import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:oktoast/oktoast.dart';
import 'package:widget_rat/init.dart';
import 'package:widget_rat/providers/themeView/viewmodel.dart';
import 'package:widget_rat/router/routes.dart';
import 'package:widget_rat/common/style/theme.dart';
import 'package:widget_rat/utils/constants.dart';
import 'package:widget_rat/utils/global.dart';
import 'package:widget_rat/utils/logger.dart';

import 'api/api.dart';
import 'api/dataClass/Oss_BaseUrl_data.dart';
import 'http/dio_instance.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(  //设置状态栏透明
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(ProviderScope(child: const MyApp()));     // ProviderScope 包裹
}


class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  bool _initialized = false;

  @override
  void initState() {
    DioInstance.instance().initDio(baseUrl: Constants.baseUrl); /// 初始化 Dio
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!_initialized) {
        await initializeApp(); // 传入 ref
        _initialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeModeState = ref.watch(themeModeNotifierProvider);
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
