import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CapsuleTags extends StatelessWidget {
  /// 标签文本列表
  final List<String> tags;
  /// 每个标签的颜色列表（长度应与 `tags` 相同）
  final List<Color>? tagColors;
  /// 胶囊标签的统一背景色（当 `tagColors` 未提供时使用）
  final Color defaultColor;
  /// 文本样式
  final TextStyle textStyle;
  /// 每个标签的图标列表（长度应与 `tags` 相同）
  final List<IconData>? tagsIcons;
  /// 胶囊标签的固定高度（默认为 null，表示自动高度）
  final double? fixedHeight;
  /// 圆角半径
  final double borderRadius;
  /// icon 的尺寸
  final double iconSize;
  /// capsule Padding
  final EdgeInsets padding;

  /// 点击回调
  final void Function(int index, String tag)? onTap;

  const CapsuleTags({
    Key? key,
    required this.tags,
    this.tagColors,
    this.defaultColor = const Color(0xFFE0E0E0),
    this.textStyle = const TextStyle(fontSize: 12, color: Colors.black87),
    this.tagsIcons,
    this.fixedHeight,
    this.borderRadius = 20.0,
    this.onTap,
    this.iconSize = 10.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  }) : super(key: key);

  BorderRadius _buildRadius(int index, int length) {
    if (length == 1) return BorderRadius.all(Radius.circular(borderRadius));
    if (index == 0) return BorderRadius.only(topLeft: Radius.circular(borderRadius), bottomLeft: Radius.circular(borderRadius));
    if (index == length - 1) return BorderRadius.only(topRight: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius));
    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(tags.length, (index) {
        // 获取当前标签的颜色（优先使用 tagColors，否则使用 defaultColor）
        final currentColor = tagColors?.isNotEmpty == true && index < tagColors!.length
            ? tagColors![index]
            : defaultColor;

        // 获取当前标签的图标（如果提供了）
        final currentIcon = tagsIcons?.isNotEmpty == true && index < tagsIcons!.length
            ? tagsIcons![index]
            : null;

        return GestureDetector(
          onTap: () => onTap?.call(index, tags[index]),
          child: Container(
            padding: padding,
            height: fixedHeight, // 固定高度（如果设置了）
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: _buildRadius(index, tags.length),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (currentIcon != null)
                  Icon(currentIcon, size:  iconSize, color: textStyle.color),
                if (currentIcon != null) SizedBox(width: 4), // 图标和文本之间的间距
                Text(tags[index], style: textStyle),
              ],
            ),
          ),
        );
      }),
    );
  }
}
