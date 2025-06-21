import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/api/api.dart';
import 'package:widget_rat/pages/LoginRegisterPage/model.dart';
import 'package:widget_rat/utils/logger.dart';


class LoginRegisterNotifier extends StateNotifier<LoginRegisterState>{
  LoginRegisterNotifier() : super(
    LoginRegisterState(
      isLoading: false
    )
  );

  /// 输入框更新state
  void updateContent(String input, bool isPWD){
    isPWD ? state = state.CopyWith(inputPassword: input) :
      state = state.CopyWith(inputAccount: input);
  }

  ///登录
  Future<dynamic> submitLogin()async{
    bool _isLoginSucc = false;
    if (state.isLoading){logger.d("Locked"); return _isLoginSucc;}

    state = state.CopyWith(isLoading: true);
    logger.d("act: ${state.inputAccount}, pwd: ${state.inputPassword}");
    if(state.inputPassword.length != 0 && state.inputAccount.length != 0){
      //TODO : 其他合法性判断 or 拦截器
      try{
        final response = await Api.instance.login(state.inputAccount, state.inputPassword);
        logger.d("登录成功！");
        _isLoginSucc = true;
      }catch(e){
        logger.d("登录失败！", error: e);
        state = state.CopyWith(isLoading: false);
      }

    }
    state = state.CopyWith(isLoading: false);
    return _isLoginSucc;
  }


}

final LoginRegistgerNotifierProvider = AutoDisposeStateNotifierProvider<LoginRegisterNotifier, LoginRegisterState>(
        (ref) => LoginRegisterNotifier(),
);