import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_rat/common/style/theme.dart';
import 'package:widget_rat/pages/myPage/viewmodel.dart';
import 'package:widget_rat/providers/UserProvider/viewmodel.dart';

import '../../providers/ThemeProvider/viewmodel.dart';
import '../../router/routes.dart';
import '../../utils/logger.dart';
import '../../widgets/avatar_Container/avatar_Container.dart';

class MyPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final GoRouter _router = GoRouter.of(context);
    // logger.d('Edit Node 当前路由名称: ${_router.routeInformationProvider.value.uri}');

    final state = ref.watch(mypageNotifierProvider);
    final themeModeState = ref.watch(themeModeNotifierProvider);  /// 日夜切换


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 30.sp,
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
              _avatarCard(context, ref,
                  state.avatarUrl,
                  state.username,
                  state.authorid,
                  state.userBio
              ),
              _likedCard(context, ref),
              _settingsCard(context, ref),
            ],
          ),
        ),
      ),
    );
  }


  Widget _avatarCard(BuildContext context, WidgetRef ref,
      String avatarUrl,
      String username,
      num authorid,
      String userBio
      ){
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
                  // ref.read(mypageNotifierProvider.notifier).pickAvatarFromGallery();
                },
                child: Column(
                  children: [
                    Container(          /// 头像容器
                      margin: EdgeInsets.symmetric( horizontal:10.sp),
                      decoration: BoxDecoration(

                      ),
                      child: AvatarContainer(
                        size: 40.sp,
                        avatarImg: NetworkImage(avatarUrl),
                      ),
                    ),
                    Container(   ///姓名 + 其他信息
                      decoration: BoxDecoration(

                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            child: Text("${username}",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            child: Text("${userBio}",
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
    final List<List> _likedItemKV = [
      [Icons.my_library_add_outlined, "Posts"],
      [Icons.bookmark_border_outlined, "Mark"],
      [Icons.star_border_rounded, "Subscribe"],
      [Icons.history, "History"],
    ];
    return Container(
      margin: EdgeInsets.only(top: 10.sp,right: 10.sp,left: 10.sp),
      height: 60.sp,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          _buildLikedItem(context,ref, _likedItemKV[0]),
          _buildLikedItem(context,ref, _likedItemKV[1]),
          _buildLikedItem(context,ref, _likedItemKV[2]),
          _buildLikedItem(context,ref, _likedItemKV[3]),
        ]
      )
    );
  }

  Widget _buildLikedItem(BuildContext context, WidgetRef ref, List KV){
    return Container(
      margin: EdgeInsets.only(right: 10.sp,left: 10.sp),
      height: 60.sp,
      width: 60.sp,
      decoration: BoxDecoration(
        borderRadius: AppTheme.defaultBorderRadius,
        // color: Colors.red,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.sp),
            child: Icon(
              KV[0],
              color: Theme.of(context).colorScheme.secondary,
            )
          ),
          Container(
            margin: EdgeInsets.only(top: 3.sp),
            child: Text("${KV[1]}",style :TextStyle(
              fontSize: 10.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ))
          )
        ]
      )
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
      [Icons.manage_accounts_outlined, "Manage", RouteNames.EditMePage],
      [Icons.info_outline, "About", "/my/about"],
      [Icons.settings_sharp, "Settings", "/my/settings"],
    ];
    return GestureDetector(
      onTap: () {
        context.goNamed(iconTextKV[index][2]);    /// jump to page /my/...
      },
      child: Container(
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
              SizedBox(width: 10.sp,),
              Icon(iconTextKV[index][0],size: 20.sp,color: Theme.of(context).colorScheme.primary,),
              SizedBox(width: 6.sp,),
              Text("${iconTextKV[index][1]}",style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant,fontSize: 12.sp,),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_outlined,size: 15.sp,color: Theme.of(context).colorScheme.onSurfaceVariant,),
              SizedBox(width: 5.sp,),
            ],
          ),
        )
      ),
    );
  }

}





