// utils/logger.dart
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
  level: Level.debug, // 设置日志级别
);
