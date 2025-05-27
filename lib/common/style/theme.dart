import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  //===================== Dark Mode Colors =====================
  static const Color _darkBackground = Color(0xFF0D0D0D); // 更深的背景
  static const Color _darkPrimary = Color(0xFF8A2BE2);    // 高饱和紫（原6A3B8F→8A2BE2）
  static const Color _darkSecondary = Color(0xFF00FF7F);  // 荧光绿（原4CAF7D→00FF7F）
  static const Color _darkText = Color(0xFFF0F0F0);       // 更亮的文字
  static const Color _darkTextSecondary = Color(0xFFAAAAAA);
  static const Color _darkSurface = Color(0xFF1A1A1A);    // 卡片背景
  static const Color _darkSurfaceSecondary = Color(0xFF333333);
  static const Color _darkSurfaceInverse = Color(0xFFC0C0C0);

  //===================== Light Mode Colors =====================
  static const Color _lightBackground = Color(0xFFF8F8F8);
  static const Color _lightPrimary = Color(0xFF9B30FF);   // 亮紫色
  static const Color _lightSecondary = Color(0xFF00CC66); // 鲜绿色
  static const Color _lightText = Color(0xFF222222);      // 更深文字
  static const Color _lightTextSecondary = Color(0xFF666666);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightSurfaceSecondary = Color(0xFFE0E0E0);

  //===================== 动态交互色 =====================
  static const Color _errorColor = Color(0xFFFF5252);     // 高饱和红（错误提示）
  static const Color _hoverColor = Color(0xFFFF00FF);    // 炫彩紫（悬停特效）

  //===================== ColorScheme 配置 =====================
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: _darkPrimary,
      secondary: _darkSecondary,
      surface: _darkSurface,
      surfaceBright: _darkSurfaceSecondary,
      background: _darkBackground,
      error: _errorColor,
      onPrimary: Colors.black,          // 紫色上的文字用黑色（高对比）
      onSecondary: Colors.black,        // 荧光绿上的文字用黑色
      onSurface: _darkText,
      onSurfaceVariant: _darkTextSecondary,
      onBackground: _darkText,
      onError: Colors.white,
    ),
    useMaterial3: true,
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: _lightPrimary,
      secondary: _lightSecondary,
      surfaceBright : _lightSurfaceSecondary,
      surface: _lightSurface,
      background: _lightBackground,
      error: _errorColor,
      onPrimary: Colors.white,          // 亮紫色上的文字用白色
      onSecondary: Colors.white,        // 鲜绿色上的文字用白色
      onSurfaceVariant: _lightTextSecondary,
      onSurface: _lightText,
      onBackground: _lightText,
      onError: Colors.white,
    ),
    useMaterial3: true,
  );

  //===================== 直接可用的颜色（按需调用） =====================
  static const Color neonEffect = _darkSecondary; // 荧光绿特效（如按钮光效）
  static const Color codeHighlight = Color(0xFF00FF00); // 代码高亮绿

  static  BorderRadius defaultBorderRadius = BorderRadius.circular(5.sp);
}

/// 标签颜色枚举
class tagColorIconenum  {
  static final Map<String,List> tagStyleEnum= {
    'question': [Color(0xB87FFFF8),Icons.question_mark_sharp],
    'showcase': [Color(0xB8FFF681),Icons.handyman_outlined],
    'discussion': [Color(0xB8FFABC8),Icons.forum_outlined],
  };
}
