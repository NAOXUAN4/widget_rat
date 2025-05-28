import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:widget_rat/pages/CommunityPage/viewmodel.dart';
import 'package:widget_rat/widgets/capsuleTags/capsule_tags.dart';

import '../../common/style/theme.dart';
import '../../router/routes.dart';
import '../../utils/global.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CommunityPageState();
  }
}

class _CommunityPageState extends State<CommunityPage> {
  static const bool hasPic = false;    // 是否有图片
  late final RefreshController _refreshController  = RefreshController();       //下拉刷新控制器
  late final TextEditingController _searchInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Community"),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add_outlined),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              context.push(RouteNames.createpost);
            },
          ),
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              showToast("搜索");
            },
          ),
          IconButton(
            icon: Icon(Icons.mail_outline_outlined),
            onPressed: () {
              showToast("信息");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Consumer(
              builder: (context,ref,__) {
                return SmartRefresher(    ///  下拉刷新
                  controller: _refreshController,
                  enablePullUp: true,
                  enablePullDown: true,
                  header: MaterialClassicHeader(),
                  footer: ClassicFooter(),
                  onLoading: () async{
                    await ref.read(ComListStateNotifierProvider.notifier).fetchPostsList(isRefresh: false).then((value) {
                        _refreshController.loadComplete();
                      });
                  },
                  onRefresh: () async{
                    await ref.read(ComListStateNotifierProvider.notifier).fetchPostsList(isRefresh: true).then((onValue){
                      _refreshController.refreshCompleted();
                    });
                  }, //使用safe_area，防止顶部导航栏被遮挡
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(                   /// PostList 上方栏
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                              ),
                              height: 30.sp, // 根据需要调整高度
                              padding: EdgeInsets.only(top: 5.sp, right: 10.sp, bottom: 2.sp),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Container(               /// 换一批按钮
                                    margin: EdgeInsets.only(left : 15.sp,right: 0.sp, bottom: 2.sp),
                                    height: 28.sp,
                                    width: 70.sp,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(25),
                                      // border: Border.all(color: Theme.of(context).colorScheme.primary.withAlpha(60), width: 1.sp),
                                      borderRadius: BorderRadius.circular(15.sp),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.autorenew_rounded,
                                          size: 15.sp,
                                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                                        ),
                                        Text("Shuffle",style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant,),)
                                      ],
                                    ),
                                  ),


                                ],
                              )
                            ),
                            _PostsListView(),
                          ],
                        )
                    )
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _PostsListView(){
    return Consumer(
      builder: ( _, ref, __) {
        final comListState = ref.watch(ComListStateNotifierProvider);
        return ListView.builder( //下方内容
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _ListItem(index: index, comListState: comListState);
          },
          itemCount: comListState.postsList.length,);
      }
    );

  }

  Widget _ListItem({required int index, required ComListState comListState}){
    return Container(
      height: hasPic ? 240.sp : 90.sp,
      margin: EdgeInsets.symmetric(vertical: 1.sp),  // 轴向间距
      padding: EdgeInsets.all(2.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          _ListItemTitle(
            postid: comListState.postsList[index].id ?? 0,
            title: comListState.postsList[index].title ?? "Null",
            createdAt: comListState.postsList[index].createdAt ?? "Null",
            postType: comListState.postsList[index].postType ?? "Null",
            avatorUrl: comListState.postsList[index].authorAvatarUrl ?? "NULL",
            author: comListState.postsList[index].author  ?? 1,    /// 作者id
          ),
          // _ListItemContent(),
        ]
      )
    );
  }

  Widget _ListItemTitle({ required num postid,
                          required String title,        /// 标题
                          required String createdAt,   /// 创建时间
                          required String postType,     /// 分类
                          required String avatorUrl,         /// 头像
                          required num author,
  }){
    return Container(
      key: Key("_ListItemTitle${postid}"),
      height: 80.sp,
      width:  double.infinity,
      margin: EdgeInsets.symmetric(vertical: 1.sp),
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        // color: Colors.blue,
      ),
      child: Row(                    // ListItem标题: 头像 + 标题分类 + 更多
        children: [
          Container(
            width: 60.sp,
            height: 60.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary, // 边框颜色
                width: 2.sp,        // 边框宽度
              ),
            ),
            child: CircleAvatar(
              radius: 30.sp,
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundImage: NetworkImage("https://${Global.ossAvatarUrl}${author}/test_upload.png"),
            ),   //  用户头像图片
          ),   // 头像
          GestureDetector(
            onTap: () {
              context.push(
                  '${RouteNames.postdetailPage}/${postid}'
              );
            },
            child: Container(
              height: 70.sp,
              width: 250.sp,
              margin: EdgeInsets.symmetric(horizontal: 5.sp),
              decoration: BoxDecoration(
                // color: Colors.green,
              ),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      width: 200.sp,
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                      ),
                      margin: EdgeInsets.only(top: 15.sp,bottom: 5.sp,right: 80.sp),
                      child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 18.sp,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // color: Colors.red
                      ),
                      child: Row(           // 分类 + 时间
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(               // 胶囊标签
                              child: CapsuleTags(
                                tags: [
                                  "${postType}",
                                ],             // TODO：需要考虑最多标签数
                                tagsIcons: [
                                  tagColorIconenum.tagStyleEnum[postType]![1],
                                ],
                                tagColors: [
                                  tagColorIconenum.tagStyleEnum[postType]![0],
                                ],
                                fixedHeight: 15.sp,
                                textStyle: TextStyle(
                                  fontSize: 5.sp,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                borderRadius: 4.sp,
                              )
                          ),
                          Container(        //  修改时间
                            margin: EdgeInsets.symmetric(vertical: 2.sp),
                            width: 100.sp,
                            height: 18.sp,
                            decoration: BoxDecoration(
                              // color: Colors.yellow,
                            ),
                            child:  Text(
                                "${createdAt}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
                )
              ),
            ),
          ),      // 标题分类
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0.sp),
            width: 25.sp,
            height: 70.sp,
            decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.surface,
            ),
            child: Container(
                margin: EdgeInsets.only(bottom: 40.sp),
                child: Icon(
                    Icons.more_vert,
                    size: 15.sp,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                )),
          ),      // 更多icon
        ]
      ),
    );
  }

  Widget  _ListItemContent(){
    return Container(
      height: hasPic ? 150.sp : 70.sp,
      width:  double.infinity,
      margin: EdgeInsets.symmetric(vertical: 1.sp),
      padding: EdgeInsets.all(5.sp),
      decoration: BoxDecoration(
        // color: Colors.red,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.blue,
            ),
            child: Text(           // 正文
              "",
              style: TextStyle(
                fontSize: 12.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: hasPic ? 2 : 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          hasPic ? Container(        //  图片container
            margin: EdgeInsets.only(top: 5.sp),
            height: 100.sp,
            width: double.infinity.sp,
            decoration: BoxDecoration(
              // color: Colors.lightGreenAccent,
            ),
            child: _ListItemImgs(imgs: [
              AssetImage("assets/images/dav.jpg"),
              AssetImage("assets/images/dav.jpg"),
              AssetImage("assets/images/dav.jpg"),
              AssetImage("assets/images/dav.jpg"),
            ]),      // 图片排列

          ) : Container(),
        ],
      ),
    );
  }

  Widget _ListItemImgs({required List<AssetImage> imgs}) {
    final int imgNums = imgs.length;
    if (imgNums <= 3) {
      // 小于等于 3 张图片：水平排列
      return Row(
        children: imgs.map((img) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.all(2.sp),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: img,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.sp),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      // 大于 3 张图片：左边一张大图，右边垂直排列两张小图，并在下方添加“更多”图标
      return Row(
        children: [
          // 左边大图
          Expanded(
            flex: 2, // 占 2 份宽度
            child: Container(
              margin: EdgeInsets.all(2.sp),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imgs[0],
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.sp),
              ),
            ),
          ),
          // 右边小图和“更多”图标
          Expanded(
            flex: 1, // 占 1 份宽度
            child: Column(
              children: [
                // 第一张小图
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(2.sp),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imgs[1],
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                  ),
                ),
                // 第二张小图
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2.sp),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imgs[2],
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                      Positioned(
                        bottom: 1.sp,         // TODO: Icon添加黑背景
                        right: 5.sp,
                        child: Icon(
                            Icons.more_horiz,
                            size: 18.sp,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),

                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }



}