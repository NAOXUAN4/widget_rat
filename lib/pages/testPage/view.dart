import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'view.g.dart';

class TestPage extends ConsumerWidget{
  const TestPage({super.key});

  @riverpod
  String test(TestPageRef ref){
    return 'test';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

