import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_rat/pages/testPage/viewmodel.dart';
import 'package:widget_rat/router/routes.dart';
import 'package:widget_rat/utils/global.dart';


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
                ElevatedButton(
                  onPressed: (){
                    ref.read(counterNotifierProvider.notifier).postPostsTest();
                  },
                  child: Text("postPosts"),
                ),
                ElevatedButton(
                  onPressed: (){
                    ref.read(counterNotifierProvider.notifier).getcreateComments();
                  },
                  child: Text("createComments")
                ),
                ElevatedButton(
                    onPressed: (){
                      ref.read(counterNotifierProvider.notifier).uploadAvatarTest();
                    },
                    child: Text("uploadAvatarTest")
                ),
                ElevatedButton(
                    onPressed: (){
                      ref.read(counterNotifierProvider.notifier).logoutTest();
                    },
                    child: Text("logouttest")
                ),
                ElevatedButton(
                    onPressed: ()=>context.go(RouteNames.loginPage),
                    child: Text("go2LoginPage")
                ),
                ElevatedButton(
                    onPressed: (){
                      print(Global.isLogin);
                      print(Global.userAvatarPath);
                    },
                    child: Text("test")
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}

