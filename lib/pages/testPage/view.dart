import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/pages/testPage/viewmodel.dart';


class TestPage extends StatelessWidget{
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer(
        builder: (_, ref, __){
          final count = ref.watch(counterNotifierProvider);
          return ElevatedButton(
            onPressed: (){
              ref.read(counterNotifierProvider.notifier).increment();
            },
            child: Text("$count"),
          );
        },
      ),
    );
  }
}

