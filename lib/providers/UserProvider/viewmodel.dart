import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/utils/logger.dart';

import '../../api/api.dart';
import 'model.dart';



class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(
    isLoading: false,
    ossAvatarUrl: "",
    loginStatus: true,
    ossUrl: ""
  ));

  // Future<void> getUserInfo() async {
  //   state = state.copyWith(
  //     isLoading: true,
  //   );
  //
  //   final response = await Api.instance.me();
  //   logger.d("${response}");
  //   if (response != null) {
  //     state = state.copyWith(
  //       authid: response.id,
  //       username: response.username,
  //       isLogin: true,
  //       isLoading: false,
  //     );
  //   }
  //
  //
  // }


}

final UserNotifierProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);