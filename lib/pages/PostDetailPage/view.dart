import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:oktoast/oktoast.dart';
import 'package:widget_rat/api/dataClass/Post_Detail_data.dart';
import 'package:widget_rat/pages/PostDetailPage/viewmodel.dart';
import 'package:widget_rat/utils/global.dart';

import '../../common/style/theme.dart';
import '../../widgets/avatar_Container/avator_Container.dart';
import '../../widgets/capsuleTags/capsule_tags.dart';

class PostDetailPage extends StatefulWidget {
  final String postId;

  const PostDetailPage({required String this.postId, Key? key}) : super(key: key);  /// 构造函数传参

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  _PostDetailPageState();
  }
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.primary
            ),
            onPressed: () {
              showToast("更多");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(  /// 帖子内容
        child: Consumer(
          builder: (context, ref, __) {
            final PostDetailState postDetialstate = ref.watch(postDetailNotifierProvider(widget.postId));
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
              ),
              child: _DetailListView(postDetialstate: postDetialstate),
            );
          }
        ),
      ),
      bottomNavigationBar: Container(   /// 底部栏： 点赞收藏评论
        height: 45.sp,
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: _DetailBottomBar()
        ),
      )
    );
  }


  /// 标题 + 作者 + 工具（如果有） + 文章 + 评论
  Widget _DetailListView({required PostDetailState postDetialstate}) {
    if (postDetialstate.isLoading) {        /// isLoading 时，加载中
      return Center(child: LinearProgressIndicator());
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Container(
            // height: 2000.sp,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailTitle(
                  title: postDetialstate.postTitle,
                  category: postDetialstate.postDetail.postType ?? "unk",
                  createTime: postDetialstate.postDetail.createdAt ?? "unk",
                  updateTime: postDetialstate.postDetail.updatedAt ?? "unk",
                ),     /// 标题部分 => 标题 + 分类 + 创建时间 + 更新时间
                _DetailAuthorBar(
                  author: postDetialstate.postDetail.author ?? 0,
                  authorName: postDetialstate.postDetail.authorUsername ?? "unk",
                ),
                _DetailToolBar(
                  tool: postDetialstate.postDetail.tool ?? "unk",
                ),      /// 工具 介绍部分  /// TODO: 先搞论坛再搞工具
                _DetailContent(
                  content: postDetialstate.postContents,
                ),
                _DetailComment(
                  commentList: postDetialstate.postComments ?? [],
                ),
              ]
            )
          )
        ]
      )
    );
  }

  Widget _DetailTitle({required String title,
                        required String category,
                        required String createTime,
                        required String updateTime}) {    /// 标题部分 => 标题 + 分类 + 创建时间 + 更新时间
    return Container(
      width: double.infinity,
      // height: 100.sp,
      padding: EdgeInsets.only(left: 15.sp,right: 15.sp, top: 10.sp),  /// 标题Container Padding
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.primary.withAlpha(10),
            width: 2.sp,
          )
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.sp),
            alignment: Alignment.centerLeft,
            child: Text(                       /// 标题正文
                "${title}",
                style: TextStyle(
                    fontSize: 25.sp,
                    color: Theme.of(context).colorScheme.onSurfaceVariant
                )
            )
          ),
          Container(
            height: 30.sp,
            alignment: Alignment.centerLeft,
            child: Row(                      /// 分类正文 + 时间正文
              children: [
                Container(                  /// 分类正文
                  width: 150.sp,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: CapsuleTags(
                    tags: ["${category}","unk"],
                    tagsIcons: [tagColorIconenum.tagStyleEnum[category]?[1]],
                    tagColors: [tagColorIconenum.tagStyleEnum[category]?[0]],
                  )
                ),
                Container(                 /// 时间正文 : 创建时间 + 更新时间
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.query_builder,
                        size: 18.sp,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,),
                      Text(
                        " ${createTime}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Theme.of(context).colorScheme.onSurfaceVariant
                        )
                      ),
                    ],
                  )
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _DetailAuthorBar({required num author, required String authorName}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.sp),
      height: 50.sp,
      decoration: BoxDecoration(
        // color: Colors.lightGreen,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary.withAlpha(10),
            width: 2.sp,
          )
        ),
      ),
      child: Row(
        children: [
          Container(
            child: AvatorContainer(
              size: 16.sp,
              avatorUrl: "https://${Global.ossAvatarUrl}${author}/test_upload.png",
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
            child: Text(
              "${authorName}",
              style: TextStyle(
                fontSize: 20.sp,
                color: Theme.of(context).colorScheme.onSurfaceVariant
              )
            )
          ),
          Spacer(),
          Container(
            child: Icon(Icons.add_outlined,
              size: 20.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,),
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
          )
        ]
      )
    );
  }

  Widget _DetailToolBar({required String tool}) {
    return  Container(
    );
  }

  Widget _DetailContent({required List<PostDetailContent> content}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
      decoration: BoxDecoration(
      ),
      child :ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: content.length,
        itemBuilder: (context,index){
          final Contentitem = content[index];
          switch (Contentitem.type){
            case "text":
              return GptMarkdown(
                "${Contentitem.value}",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant
                ),
              );
            case "code":
              return GptMarkdown(
                "${Contentitem.value}",
              );
            case "image":
              return GptMarkdown(
                "${Contentitem.value}",
              );
          }
    }),
    );
  }

  Widget _DetailComment({required List<PostDetailComments> commentList}) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: commentList.length,
        itemBuilder: (context,index){
          final commentitem = commentList[index];
          return  Container(           /// 评论结构 ： （评论者头像 + 评论者昵称 + 评论时间 ） + 内容
            decoration: BoxDecoration(
              // color: Colors.blueAccent,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withAlpha(20),
                  width: 2.sp,
                )
              ),
            ),
            child: Column(
              children: [
                Container(        /// 评论者头像 + 评论者昵称 + 评论时间
                  margin: EdgeInsets.only(left: 10.sp,bottom: 2.sp,right: 10.sp,top: 6.sp),
                  height: 50.sp,
                  decoration: BoxDecoration(
                    // color: Colors.lightGreen,
                  ),
                  child: Row(     /// 评论者头像 + 评论者昵称 + 评论时间
                    children: [
                      Container(     /// 评论者正文
                        alignment: Alignment.center,
                        height: 40.sp,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                        ),
                        child: AvatorContainer(
                          size: 16.sp,
                          avatorUrl: "https://${Global.ossAvatarUrl}${commentitem.author}/test_upload.png",
                        ),
                      ),
                      Column(
                        children: [
                          Container(   /// 评论者昵称正文
                            width: 150.sp,
                            margin: EdgeInsets.only(top: 8.sp,left: 5.sp),
                            decoration: BoxDecoration(
                              // color: Colors.blue,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "${commentitem.authorUsername}",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant
                                )
                            ),
                          ),
                          Container(   /// 评论时间正文
                            width: 150.sp,
                            margin: EdgeInsets.only(left: 5.sp),
                            child: Row(children: [
                              Icon(Icons.reply_sharp,size: 15.sp,color: Theme.of(context).colorScheme.onSurfaceVariant,),
                              Text(
                                "${commentitem.createdAt}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant
                                ),
                              ),
                            ],),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(        /// 内容
                  height: 40.sp,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 45.sp,bottom: 2.sp,right:10.sp),

                  child: GptMarkdown(
                    "${commentitem.content}",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.onSurfaceVariant
                    ),
                  ),

                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _DetailBottomBar() {
    return  Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(             /// 底部栏 ： 评论 + 点赞 + 收藏
        children: [
          Container(
            width: 240.sp,
            height: 23.sp,
            margin: EdgeInsets.only(left: 10.sp,bottom: 2.sp),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(60),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(color: Colors.transparent)),  //未激活状态
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5.r),
                    borderSide: BorderSide(color: Colors.transparent)),
                  )
              ),
            ),
          SizedBox(width: 30.sp),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            width: 30.sp,
            height: 50.sp,
            child: Icon(Icons.bookmark,
              size: 28.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(80),),
          ),
          Container(
            margin: EdgeInsets.only(left: 6.sp,top: 1.sp),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            width: 30.sp,
            height: 50.sp,
            child: Icon(Icons.messenger,
              size: 24.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(80),),
          )
        ]
      )
    );
  }



}