import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_rat/common/style/theme.dart';
import 'package:widget_rat/pages/LoginRegisterPage/viewmodel.dart';
import 'package:widget_rat/pages/LoginRegisterPage/widget/actTextField.dart';
import 'package:widget_rat/pages/LoginRegisterPage/widget/loginCard.dart';
import 'package:widget_rat/pages/LoginRegisterPage/widget/registerCard.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  TextEditingController _pwdController = TextEditingController();
  TextEditingController _actController = TextEditingController();
  TextEditingController _confirmpwdController = TextEditingController();
  
  final bool isRegister = false;  /// 测试变量

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pwdController.dispose();
    _actController.dispose();
    _confirmpwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ViewModel = ref.watch(LoginRegistgerNotifierProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: EdgeInsets.only(top: 30.sp, left: 20.sp, right: 20.sp),
        child: isRegister ? RegisterCard(_actController, _pwdController, _confirmpwdController, context, ref)
            : LoginCard(_actController, _pwdController, context, ref),
      ),
    );
  }
}