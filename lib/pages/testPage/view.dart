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
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    ref.read(counterNotifierProvider.notifier).LoginTest();
                  },
                  child: Text("Login"),
                ),
                ElevatedButton(
                  onPressed: (){
                    ref.read(counterNotifierProvider.notifier).meTest();
                  },
                  child: Text("Me"),
                ),
                ElevatedButton(
                  onPressed: (){
                    ref.read(counterNotifierProvider.notifier).registerTest();
                  },
                  child: Text("register"),
                ),
                ElevatedButton(
                  onPressed: (){
                    ref.read(counterNotifierProvider.notifier).getPostsListTest();
                  },
                  child: Text("postsList"),
                ),
                ElevatedButton(
                  onPressed: (){
                    ref.read(counterNotifierProvider.notifier).getPostsDetailTest();
                  },
                  child: Text("postsDetail"),
                ),
                ElevatedButton(
                  onPressed: (){
                    ref.read(counterNotifierProvider.notifier).getOssBaseUrlTest();
                  },
                  child: Text("OssBaseUrl"),
                ),



              ],
            ),
          );
        },
      ),
    );
  }
}

