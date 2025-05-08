import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';


class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);  // 初始状态
  void increment() => state++;
  void decrement() => state--;
  Future LoginTest() async{
    var response = await Api.instance.login("Nanyian", "nao2004");
  }
  Future meTest() async{
    var response = await Api.instance.me();
  }
}

final counterNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>(
      (ref) => CounterStateNotifier(),
);