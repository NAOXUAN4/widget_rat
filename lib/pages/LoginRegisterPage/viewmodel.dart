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
  void updateContent(String input, int inputType){   /// 0: account 1: pwd 2.Repwd
    inputType == 0 ? state = state.CopyWith(inputAccount: input)
        : inputType == 1 ? state = state.CopyWith(inputPassword: input)
          : state = state.CopyWith(inputRePassword: input);
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

  ///注册
  Future<dynamic> submitRegister()async{
    bool _isRegisterSucc = false;
    if (state.isLoading){logger.d("Locked"); return _isRegisterSucc;}

    state = state.CopyWith(isLoading: true);
    logger.d("act: ${state.inputAccount}, pwd: ${state.inputPassword}, repwd: ${state.inputRePassword}");
    if(state.inputPassword.length != 0
        && state.inputAccount.length != 0
        && state.inputRePassword.length !=0
        && state.inputRePassword == state.inputPassword){
      //TODO : 其他合法性判断 or 拦截器
      try{
        final response = await Api.instance.register(state.inputAccount, state.inputPassword, state.inputRePassword);
        logger.d("注册成功！");
        _isRegisterSucc = true;
      }catch(e){
        logger.d("注册失败！", error: e);
        state = state.CopyWith(isLoading: false);
      }

    }else{
      logger.e("输入不合法！");
    }
    state = state.CopyWith(isLoading: false);
    return _isRegisterSucc;
  }

}

final LoginRegistgerNotifierProvider = AutoDisposeStateNotifierProvider<LoginRegisterNotifier, LoginRegisterState>(
        (ref) => LoginRegisterNotifier(),
);