import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/utils/constants.dart';
import 'package:widget_rat/utils/sp_utils.dart';

import 'model.dart';


class ThemeModeNotifier  extends StateNotifier<ThemeModeState> {
  ThemeModeNotifier() : super(ThemeModeState());

  Future<void> toggleTheme() async {
    state = ThemeModeState(isNight: !state.isNight);  /// 切换主题
    await SpUtils.saveBool(Constants.SP_nightModeStatus, state.isNight);
  }

  void initNightMode(){
    SpUtils.getBool(Constants.SP_nightModeStatus).then((v){
      state = ThemeModeState(isNight: v ?? false);
    });

  }
}

final themeModeNotifierProvider = StateNotifierProvider<ThemeModeNotifier, ThemeModeState>(
      (ref) => ThemeModeNotifier(),
);

