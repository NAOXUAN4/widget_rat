import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_rat/pages/LoginRegisterPage/widget/actTextField.dart';

import '../../../common/style/theme.dart';
import '../viewmodel.dart';

Widget LoginCard(TextEditingController _actController, TextEditingController _pwdController,
    BuildContext context, WidgetRef ref){
  return Container(
    padding: EdgeInsets.only(top: 100.sp, left: 20.sp, right: 20.sp),
    child: Container(
      height: 380.sp, // 增加高度以容纳更多内容
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppTheme.defaultBorderRadius,
      ),
      child: Column(
        children: [
          // 标题
          Container(
            padding: EdgeInsets.only(top: 30.sp, bottom: 20.sp),
            child: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
              weight: 700,
            ),
          ),

          // 账号输入框
          LoginRegisterTextField(
            controller: _actController,
            hintText: 'please enter your account',
            icon: Icons.person,
            inputType: 0,
            isLogin: true,
            ref: ref,
            context: context
          ),

          // 密码输入框
          LoginRegisterTextField(
            controller: _pwdController,
            hintText: 'please enter your password',
            icon: Icons.lock,
            inputType: 1,
            isLogin: true,
            ref: ref,
            context: context
          ),

          // 登录按钮
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                /// 处理登录逻辑
                ref.read(LoginRegistgerNotifierProvider.notifier).submitLogin().then((v){
                  if (v) context.pop();   /// 退出登录界面
                });

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 15.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // 注册选项
          Container(
            padding: EdgeInsets.only(top: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account yet?',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    /// 跳转到注册页面
                    _handleRegister();
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 8.sp),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



// 处理注册逻辑
void _handleRegister() {
  // 跳转到注册页面或显示注册弹窗
  print('跳转到注册页面');
}

// 显示提示消息
void _showMessage(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}
