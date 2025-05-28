import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_rat/common/style/theme.dart';
import 'package:widget_rat/pages/myPage/viewmodel.dart';

import '../../themeviewmodel.dart';
import '../../widgets/avatar_Container/avatar_Container.dart';

class MyPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mypageNotifierProvider);
    final themeModeState = ref.watch(themeModeNotifierProvider);  /// 日夜切换
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
            icon: Icon(themeModeState.isNight?  Icons.nightlight_outlined : Icons.light_mode_outlined),
            onPressed: (){
              ref.read(themeModeNotifierProvider.notifier).toggleTheme();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(            /// 头像卡片 + profile内容
            children: [
              _avatarCard(context, ref, state.avatarUrl),
              _likedCard(context, ref),
              _settingsCard(context, ref),
            ],
          ),
        ),
      ),
    );
  }


  Widget _avatarCard(BuildContext context, WidgetRef ref, String avatarUrl){
    return Container(
      margin: EdgeInsets.only(top: 15.sp,right: 10.sp,left: 10.sp),
      height: 200.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20.sp),
              child: GestureDetector(
                onTap: (){
                  ref.read(mypageNotifierProvider.notifier).pickAvatarFromGallery();
                },
                child: Column(
                  children: [
                    Container(          /// 头像容器
                      margin: EdgeInsets.symmetric( horizontal:10.sp),
                      decoration: BoxDecoration(

                      ),
                      child: AvatarContainer(
                        size: 40.sp,
                        avatarImg: FileImage(File(avatarUrl)),
                      ),
                    ),
                    Container(   ///姓名 + 其他信息
                      decoration: BoxDecoration(

                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            child: Text("name",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            child: Text("Bio",
                              style:TextStyle(
                                fontSize: 15.sp,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),)
                          )
                        ]
                      ),

                    ),
                  ],
                ),
              ),
            ),   /// avatar Container
            Container(),   /// info Container
          ]
      ),
    );
  }

  Widget _likedCard(BuildContext context, WidgetRef ref){
    return Container(
      margin: EdgeInsets.only(top: 10.sp,right: 10.sp,left: 10.sp),
      height: 60.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Text("Likes")
      );
  }



  Widget _settingsCard(BuildContext context, WidgetRef ref){
    return Container(
      margin: EdgeInsets.only(top: 10.sp,right: 10.sp,left: 10.sp),
      height: 500.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: ListView.builder( //下方内容
        shrinkWrap: true,
        itemCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _profileListItem(context, ref, index);
        },),
    );
  }

  Widget _profileListItem(BuildContext context, WidgetRef ref,  int index){
    final List<List> iconTextKV = [
      [Icons.link, "Links"],
      [Icons.calendar_month, "Calendar"],
      [Icons.settings_sharp, "Settings"],
    ];
    return Container(
      margin: EdgeInsets.only(top: 10.sp,right: 0.sp,left: 0.sp),
      height: 40.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        // color: Colors.blue,
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: AppTheme.defaultBorderRadius,
          // color: Colors.lightGreen,
        ),
        margin: EdgeInsets.only(left: 5.sp),
        child: Row(
          children: [
            Icon(iconTextKV[index][0],size: 20.sp,color: Theme.of(context).colorScheme.primary,),
            SizedBox(width: 5.sp,),
            Text("${iconTextKV[index][1]}",style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant,fontSize: 12.sp,),),
            Spacer(),
            Icon(Icons.arrow_forward_ios_outlined,size: 15.sp,color: Theme.of(context).colorScheme.onSurfaceVariant,),
            SizedBox(width: 5.sp,),
          ],
        ),
      )
    );
  }

}





