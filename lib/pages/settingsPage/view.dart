import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_rat/pages/myPage/viewmodel.dart';

import '../../common/style/theme.dart';

class settingsPage extends ConsumerStatefulWidget {
  const settingsPage({super.key});

  @override
  ConsumerState<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends ConsumerState<settingsPage> {
  @override
  Widget build(BuildContext context) {
    final myPageVM = ref.watch(mypageNotifierProvider);  // 添加监听
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: ListView.builder( //下方内容
            shrinkWrap: true,
            itemCount: 1,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _settingsListItem(context, ref, index);
            },),
        ),
      ),
    );
  }

  Widget _settingsListItem(BuildContext context, WidgetRef ref, int index){
    const List<List> iconTextKV = [
      [Icons.logout, "Logout",]
    ];
    return GestureDetector(
      onTap: () {
        /// TODO: Switch?
        ref.read(mypageNotifierProvider.notifier).logOutAtMyPage(ref).then((onValue){
          context.pop();
        });
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


