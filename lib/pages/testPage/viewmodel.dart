import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/api/dataClass/Post_Detail_data.dart';
import 'package:widget_rat/api/dataClass/Posts_List_data.dart';

import '../../api/api.dart';
import '../../utils/logger.dart';


class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);  // 初始状态
  void increment() => state++;
  void decrement() => state--;
  // TODO: 错误返回
  Future LoginTest() async{
    var response = await Api.instance.login("dalu", "nao2004");
  }
  Future meTest() async{
    var response = await Api.instance.me();
  }
  Future registerTest() async{
    var response = await Api.instance.register("dalu", "nao2004", "nao2004");
  }
  Future getPostsListTest() async{
    var response = await Api.instance.getPostsList(1);
    logger.d("${response?[0].id}");
  }
  Future getOssBaseUrlTest() async{
    var response = await Api.instance.ossBaseUrl();
    logger.d("${response}");
  }
  Future getcreateComments() async{
    var response = await Api.instance.createComment("1", "感觉不是很好？？");
    logger.d("${response}");
  }

  Future postPostsTest() async{
    PostDetailContent postDetailContent = PostDetailContent(type:"text", value: "##test  test");
    List<Map<String, dynamic>> postDetailContentList = [postDetailContent.toJson(),postDetailContent.toJson()];
    var response = await Api.instance.postPosts("test", postDetailContentList, "discussion");
    logger.d("${response}");
  }


  Future getPostsDetailTest() async{
    var response = await Api.instance.getPostsDetail("2");
    PostDetailData postsDetailData = response;
    logger.d(postsDetailData);
  }

  Future uploadAvatarTest()async {
    final File avatarFile = File("/data/user/0/com.example.widget_rat_app/cache/aa608388-0388-43c5-9885-7b8121e7a8f7/IMG_20250527_080740.jpg");
    var response = await Api.instance.upLoadAvatar(avatarFile);
    logger.d("${response}");
  }

}

final counterNotifierProvider = StateNotifierProvider<CounterStateNotifier, int>(
      (ref) => CounterStateNotifier(),
);