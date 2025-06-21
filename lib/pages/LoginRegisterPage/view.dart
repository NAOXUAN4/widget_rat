import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_rat/common/style/theme.dart';
import 'package:widget_rat/pages/LoginRegisterPage/viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  TextEditingController _pwdController = TextEditingController();
  TextEditingController _actController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pwdController.dispose();
    _actController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ViewModel = ref.watch(LoginRegistgerNotifierProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
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
              actTextField(
                controller: _actController,
                hintText: 'please enter your account',
                icon: Icons.person,
                isPassword: false,
              ),

              // 密码输入框
              actTextField(
                controller: _pwdController,
                hintText: 'please enter your password',
                icon: Icons.lock,
                isPassword: true,
              ),

              // 登录按钮
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    /// 处理登录逻辑
                    ref.read(LoginRegistgerNotifierProvider.notifier).submitLogin().then((v){
                      _showMessage(v ? "Login Success" : "Login Failed");
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
      ),
    );
  }

  Widget actTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isPassword,
  }) {
    return Container(
      height: 60.sp,
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
      child: TextField(
        onChanged: (v){
          ref.read(LoginRegistgerNotifierProvider.notifier).updateContent(isPassword? _pwdController.text : _actController.text,
                                                                            isPassword);
        },
        controller: controller,
        obscureText: isPassword, // 密码输入框隐藏文本
        style: TextStyle(
          fontSize: 16.sp,
          color: Theme.of(context).colorScheme.primary,
          decorationStyle: TextDecorationStyle.solid,
          decorationColor: Colors.transparent,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20.sp,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            fontSize: 14.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 12.sp),
          filled: true,
          fillColor: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              width: 1.sp,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2.sp,
            ),
          ),
        ),
      ),
    );
  }

  // 处理注册逻辑
  void _handleRegister() {
    // 跳转到注册页面或显示注册弹窗
    print('跳转到注册页面');
    _showMessage('注册功能待实现');
  }

  // 显示提示消息
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}