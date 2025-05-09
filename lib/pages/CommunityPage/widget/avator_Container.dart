import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatorContainer extends StatelessWidget {

  final String avatorUrl;

  const AvatorContainer({
    Key? key,
    required this.avatorUrl,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      width: 60.sp,
      height: 60.sp,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceBright,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary, // 边框颜色
          width: 2.sp,        // 边框宽度
        ),
      ),
      child: CircleAvatar(
        radius: 30.sp,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundImage: NetworkImage(avatorUrl),
      ),   //  用户头像图片
    );
  }
}