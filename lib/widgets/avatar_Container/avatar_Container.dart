import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarContainer extends StatelessWidget {

  // final String avatarUrl;

  final ImageProvider<Object> avatarImg;

  final double size;

  const AvatarContainer({
    Key? key,
    required this.avatarImg,
    required this.size,
    // required this.avatarUrl,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      width: size*2,
      height: size*2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceBright,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withAlpha(50), // 边框颜色
          width: size/10,        // 边框宽度
        ),
      ),
      child: CircleAvatar(
        radius: size,
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundImage: avatarImg,
      ),   //  用户头像图片
    );
  }
}