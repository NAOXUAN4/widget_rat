import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatorContainer extends StatelessWidget {

  final String avatorUrl;

  final double size;

  const AvatorContainer({
    Key? key,
    required this.size,
    required this.avatorUrl,
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
        foregroundImage: NetworkImage(avatorUrl),
      ),   //  用户头像图片
    );
  }
}