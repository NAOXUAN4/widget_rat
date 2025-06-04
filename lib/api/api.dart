//api请求统一解析
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:widget_rat/api/dataClass/Oss_BaseUrl_data.dart';

import 'package:widget_rat/api/dataClass/Posts_List_data.dart';
import 'package:widget_rat/api/dataClass/Update_Me_data.dart';
import 'package:widget_rat/api/dataClass/UsersMe_Res_data.dart';
import '../http/dio_instance.dart';


import '../utils/logger.dart';
import 'dataClass/Login_Res_data.dart';
import 'dataClass/Post_Detail_data.dart';
// import 'datas/common_website_data.dart';
// import 'datas/home_Lists_data.dart';
// import 'datas/home_banner_data.dart';
// import 'datas/hot_key_data.dart';

class Api {
  static Api instance = Api._();

  Api._();

  // //获取首页轮播图数据
  // Future<List<HomeBannerData?>?> getBanner() async {
  //   // TODO: implement getBanner
  //   Response response = await DioInstance.instance().get(path: "banner/json");
  //   HomeBannerListData bannerdata = HomeBannerListData.fromJson(response.data);
  //   return bannerdata.bannerList;
  // }
  //
  // //获取首页列表数据
  // Future<List<HomeItemsData>?> getHomeListData(String? page) async {
  //   Response response = await DioInstance.instance().get(
  //       path: "article/list/$page/json"); //异步中等待返回数据，才执行下面的
  //   HomeListsData homeData = HomeListsData.fromJson(response.data);
  //   return homeData.datas;
  // }
  //
  // Future<List<HomeItemsData>?> getTopList() async {     ///发送，接收，解析 置顶列表
  //   Response response = await DioInstance.instance().get(
  //       path: "article/top/json"); //异步中等待返回数据，才执行下面的
  //   HomeTopListData homeTopListData = HomeTopListData.fromJson(response.data);
  //   return homeTopListData.topList;
  // }
  //
  /// GET "api/posts/?page=1" 获取站内文章列表
  Future<List<PostsListDataItem>?> getPostsList(int? pageNum)async {   ///发送，接收，解析 常用网页列表
    Response response = await DioInstance.instance().get(
        path: "api/posts-list/?page=${pageNum}");  //发送请求，await直到获得回复
    PostsListData postsListData = PostsListData.fromJson(response.data);  //解析json数据
    return postsListData.results;
  }

  /// GET "api/posts/:id" 获取<int: id>文章详情
  Future<dynamic> getPostsDetail(String id)async{
    Response response = await DioInstance.instance().get(
        path: "api/posts/$id/");
    PostDetailData postsDetailData = PostDetailData.fromJson(response.data);
    return postsDetailData;

  }

  ///POST "/api/posts/" 发表文章
  Future<dynamic>postPosts(String? title,List<Map<String, dynamic>> content,String? type)async{
    Response response = await DioInstance.instance().post(   //发送Post传参请求
      path: "api/posts/",
      data: {
        "title": title,
        "content": content,
        "post_type":type
      },
      options:  Options(
        contentType: "application/json"
      ),
    );
    PostDetailData postsDetailData = PostDetailData.fromJson(response.data);
    return postsDetailData;
  }

  /// POST /api/comments/ 发评论
  Future<dynamic>createComment(String postId,String content)async{
    Response response = await DioInstance.instance().post(
      path: "api/comments/",
      data: {
        "post":postId,
        "content":content
      },
      options:  Options(
        contentType: "application/json"
      ),
    );
    return PostDetailComments.fromJson(response.data);   // Comments数据格式与PostDetail中的一致
  }

  //
  // Future<List<HotKeyData>?>getHotKeyData()async{
  //   Response response = await DioInstance.instance().get(
  //       path: "hotkey/json");
  //   HotKeyListData hotkey = HotKeyListData.fromJson(response.data);
  //   return hotkey.hotkeyList;
  // }
  //

  /// POST "api/users/register/" 注册，返回JWT令牌, 用户基本信息
  Future<dynamic>register(String? username,String? password,String? repassword)async{
    Response response = await DioInstance.instance().post(   //发送Post传参请求
        path: "api/users/register",
        data: {"username":username,"password":password});
    // logger.d("${response.data}");
    try{ //若报错肯定进入过拦截器的错误处理
      response.data["errorCode"] == 0; //没被修改过，还存在"errcode"
      return true;
    }
    catch(e){
      return false;
    }//拦截器会返回true或false
  }


  /// POST "api/users/login/" 登录，返回JWT令牌
  Future<dynamic>login(String? username,String? password)async{
    Response response = await DioInstance.instance().post(        //发送Post传参请求
        path: "api/users/login/",
        data: {"username":username,"password":password,});
    // logger.d("${response.data}");
    try{ //若报错肯定进入过拦截器的错误处理
      response.data["errorCode"] == 0;                          //没被修改过，还存在"errcode
      return LoginResData.fromJson(response.data);
    }
    catch(e){
      return false;
    }//拦截器会返回true或false
  }

  /// GET "api/users/me/"  获取用户基本信息
  Future<dynamic>me()async{
    Response response = await DioInstance.instance().get(
        path: "api/users/me/");
    // logger.d("${response.data}");
    try{ //若报错肯定进入过拦截器的错误处理
      response.data["errorCode"] == 0;           //没被修改过，还存在"errcode
      return UsersMeResData.fromJson(response.data);
    }
    catch(e){
      return false;
    }//拦截器会返回true或false
  }


  /// PUT "api/users/me/update/" 修改用户信息
  Future<dynamic> updateMe(Map<String, dynamic> updateData)async{
    Response response = await DioInstance.instance().put(
        path: "api/users/me/update/",
        data: updateData,
    );
    try {
      response.data["errorCode"] == 0;
      return UpdateMeData.fromJson(response.data);
    }catch(e){
      return false;
    }

  }




  /// GET "/api/oss/baseUrl/" 获取OSS储存Url
  Future<dynamic>ossBaseUrl()async{  //登录
    Response response = await DioInstance.instance().get(
        path: "api/oss/baseUrl/");
    // logger.d("${response.data}");
    try{ //若报错肯定进入过拦截器的错误处理
      response.data["errorCode"] == 0;           //没被修改过，还存在"errcode
      return OssBaseUrlData.fromJson(response.data);
    }
    catch(e){
      return false;
    }//拦截器会返回true或false
  }



  //  Future<dynamic>logout()async{  //登录
  //   Response response = await DioInstance.instance().get(   //发送Post传参请求
  //       path: "user/logout/json",);
  //   // print(response.data);
  //   if(response.data == true){
  //     return response.data;
  //   }else{
  //     return false;
  //   }
  // }
  //

  // //收藏
  // Future<bool?> collect(String? id,bool isCollect) async{
  //   String pathCollect = isCollect? "collect": "uncollect_originId";
  //   Response response = await DioInstance.instance().post(
  //       path: "lg/$pathCollect/$id/json");
  //   if(response.data == true){
  //     return response.data;
  //   }else{
  //     return false;
  //   }
  // }
  //
  // Future<List<SearchItemsData>?> searchList(String pageCount,String keyword) async{
  //   Response response = await DioInstance.instance().post(
  //       path: "article/query/$pageCount/json",
  //       data: {"k":keyword});
  //   var searchData = SearchData.fromJson(response.data);
  //   return searchData.datas;
  // }
  //
  // Future mycollects(String pageCount) async{
  //   Response response = await DioInstance.instance().get(
  //       path: "lg/collect/list/$pageCount/json");
  //   // var mycollectsData = SearchData.fromJson(response.data);
  //   HomeListsData collectsData = HomeListsData.fromJson(response.data);  //用homeListsData解析？
  //   return collectsData.datas;
  // }

}