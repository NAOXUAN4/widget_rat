import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model.dart';




class ThemeModeNotifier  extends StateNotifier<ThemeModeState> {
  ThemeModeNotifier() : super(ThemeModeState());

  void toggleTheme() {
    state = ThemeModeState(isNight: !state.isNight);  /// 切换主题
  }
}

final themeModeNotifierProvider = StateNotifierProvider<ThemeModeNotifier, ThemeModeState>(
      (ref) => ThemeModeNotifier(),
);