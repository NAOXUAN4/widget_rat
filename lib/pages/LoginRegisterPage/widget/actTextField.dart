
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../viewmodel.dart';

Widget LoginRegisterTextField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  required int inputType,
  required bool isLogin,
  required WidgetRef ref,
  required BuildContext context,
}) {
  return Container(
    height: 60.sp,
    padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
    child: TextField(
      onChanged: (v){
        ref.read(LoginRegistgerNotifierProvider.notifier).updateContent(controller.text, inputType);
      },
      controller: controller,
      obscureText: inputType != 0, // 密码输入框隐藏文本
      style: TextStyle(
        fontSize: 16.sp,
        color: Theme.of(context).colorScheme.primary,
        decorationStyle: TextDecorationStyle.solid,
        decorationColor: Colors.transparent,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: isLogin? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
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
            color: isLogin? Theme.of(context).colorScheme.primary.withOpacity(0.3) : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            width: 1.sp,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color:  Theme.of(context).colorScheme.primary,
            width: 2.sp,
          ),
        ),
      ),
    ),
  );
}