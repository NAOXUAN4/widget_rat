import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


import '../../../common/style/theme.dart';
import '../viewmodel.dart';
import 'LoginRegisterTextField.dart';

Widget RegisterCard(TextEditingController _actController,
    TextEditingController _pwdController, TextEditingController _confirmpwdController,
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
              Icons.how_to_reg_outlined,
              color: Theme.of(context).colorScheme.secondary,
              weight: 700,
            ),
          ),

          // 账号输入框
          LoginRegisterTextField(
              controller: _actController,
              hintText: 'please enter your account',
              icon: Icons.person,
              inputType: 0,
              isLogin: false,
              ref: ref,
              context: context
          ),

          // 密码输入框
          LoginRegisterTextField(
              controller: _pwdController,
              hintText: 'please enter your password',
              icon: Icons.lock,
              inputType: 1,
              isLogin: false,
              ref: ref,
              context: context
          ),

          // 确认密码
          LoginRegisterTextField(
              controller: _confirmpwdController,
              hintText: 'please enter pwd again',
              icon: Icons.lock,
              inputType: 2,
              isLogin: false,
              ref: ref,
              context: context
          ),

          // 注册按钮
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                /// 处理登录逻辑
                ref.read(LoginRegistgerNotifierProvider.notifier).submitRegister().then((v){
                  if (v) context.pop();   /// 退出登录界面
                });

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 15.sp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

