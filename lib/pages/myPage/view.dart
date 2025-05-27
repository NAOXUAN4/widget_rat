import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_rat/common/style/theme.dart';
import 'package:widget_rat/pages/myPage/viewmodel.dart';

import '../../widgets/avatar_Container/avatar_Container.dart';

class MyPage extends ConsumerWidget {



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mypageNotifierProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(            /// 头像卡片 + profile内容
            children: [
              avatarCard(context, ref, state.avatarUrl),
              settingsCard(context, ref),
            ],
          ),
        ),
      ),
    );
  }


  Widget avatarCard(BuildContext context, WidgetRef ref, String avatarUrl){
    return Container(
      margin: EdgeInsets.only(top: 60.sp,right: 10.sp,left: 10.sp),
      height: 200.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.sp),
              child: GestureDetector(
                onTap: (){
                  ref.read(mypageNotifierProvider.notifier).pickAvatarFromGallery();
                },
                child: AvatarContainer(
                  size: 40.sp,
                  avatarImg: FileImage(File(avatarUrl)),
                ),
              ),
            ),   /// avatar Container
            Container(),   /// info Container
          ]
      ),
    );
  }

  Widget settingsCard(BuildContext context, WidgetRef ref){
    return Container(
      margin: EdgeInsets.only(top: 10.sp,right: 10.sp,left: 10.sp),
      height: 500.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

}





