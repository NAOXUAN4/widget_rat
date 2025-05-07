import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:widget_rat/widgets/capsuleTags/capsule_tags.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CommunityPageState();
  }
}

class _CommunityPageState extends State<CommunityPage> {
  static const bool hasPic = false;    // 是否有图片
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
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
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              showToast("搜索");
            },
          ),
          IconButton(
            icon: Icon(Icons.messenger_outline_sharp),
            onPressed: () {
              showToast("信息");
            },
          ),
        ],
      ),
      body: SafeArea(    //使用safe_area，防止顶部导航栏被遮挡
        child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 2.sp),
                  height: 180.sp, // 根据需要调整高度
                  color: Theme.of(context).colorScheme.surface, // 可以替换为实际的 Banner 组件或图片
                  child: Center(
                    child: Text("Banner"),
                  ),
                ),
                _ListView(),
              ],
            )
        )
      )
    );
  }

  Widget _ListView(){
    return ListView.builder( //下方内容
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _ListItem(index: index);
      },
      itemCount: 10,);

  }

  Widget _ListItem({required int index}){
    return Container(
      height: hasPic ? 240.sp : 160.sp,
      margin: EdgeInsets.symmetric(vertical: 1.sp),  // 轴向间距
      padding: EdgeInsets.all(2.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          _ListItemTitle(),
          _ListItemContent(),
        ]
      )
    );
  }

  Widget _ListItemTitle(){
    return Container(
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
              foregroundImage: AssetImage("assets/images/dav.jpg"),
            ),   //  用户头像图片
          ),   // 头像
          Container(
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
                    width: double.infinity,

                    decoration: BoxDecoration(
                      // color: Colors.amber,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5.sp),
                    child: Text(
                        "卡片标题卡片标题卡片标题卡片标题卡片标题卡片标题卡片标题卡片标题卡片标题卡片标题",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      maxLines: 2,
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
                                "标签1",
                                "标签2",
                                "标签3",

                              ],             // TODO：需要考虑最多标签数
                              tagsIcons: [Icons.account_box, Icons.access_alarms_rounded, Icons.add_a_photo_rounded],
                              tagColors: [
                                Colors.indigoAccent,
                                Colors.blueGrey,
                                Colors.lightGreen
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
                              "重新编辑于 202420242024",
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
              "卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正文卡片正卡片正文卡片正文文卡片正文卡片正文",
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