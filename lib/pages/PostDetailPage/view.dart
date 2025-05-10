import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:widget_rat/pages/PostDetailPage/viewmodel.dart';

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
        height: 30.sp,
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Text(
            "这是一个底部栏",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ),
      )
    );
  }


  /// 详细内容四段式设计 ： 标题 + 作者 + 工具（如果有） + 文章
  Widget _DetailListView({required PostDetailState postDetialstate}) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 2000.sp,
            padding: EdgeInsets.all(10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DetailTitle(
                  title: postDetialstate.postTitle,
                  category: postDetialstate.postDetail.postType ?? "unk",
                  createTime: postDetialstate.postDetail.createdAt ?? "unk",
                  updateTime: postDetialstate.postDetail.updatedAt ?? "unk",
                ),     /// 标题部分 => 标题 + 分类 + 创建时间 + 更新时间
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
      child: Text("这是标题")
    );
  }



}