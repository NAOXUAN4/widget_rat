import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/utils/logger.dart';

import '../api/api.dart';

class AuthInfo {
  final num? authid;
  final String? username;
  final bool? isLogin;
  final bool? isLoading;

  AuthInfo({
    this.authid,
    this.username,
    this.isLogin,
    this.isLoading,
  });

  AuthInfo copyWith({
    num? authid,
    String? username,
    bool? isLogin,
    bool? isLoading,
  }) {
    return AuthInfo(
      authid: authid ?? this.authid,
      username: username ?? this.username,
      isLogin: isLogin ?? this.isLogin,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}


class authinfoNotifier extends StateNotifier<AuthInfo> {
  authinfoNotifier() : super(AuthInfo());

  Future<void> getAuthInfo() async {
    state = state.copyWith(
      isLoading: true,
    );

    final response = await Api.instance.me();
    logger.d("${response}");
    if (response != null) {
      state = state.copyWith(
        authid: response.id,
        username: response.username,
        isLogin: true,
        isLoading: false,
      );
    }


  }


}

final authinfoNotifierProvider = StateNotifierProvider<authinfoNotifier, AuthInfo>(
  (ref) => authinfoNotifier(),
);