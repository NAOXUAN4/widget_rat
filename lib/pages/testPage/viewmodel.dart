import 'package:flutter_riverpod/flutter_riverpod.dart';


class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);  // 初始状态
  void increment() => state++;
  void decrement() => state--;
}

final counterNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>(
      (ref) => CounterStateNotifier(),
);