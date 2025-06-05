import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
// import 'package:markdown_editor_plus/widgets/markdown_auto_preview.dart';
import 'package:oktoast/oktoast.dart';
import 'package:widget_rat/pages/CreatePostPage/viewmodel.dart';

import '../../common/style/theme.dart';
import '../../widgets/capsuleTags/capsule_tags.dart';
import '../../widgets/markdown_editor/widgets/markdown_auto_preview.dart';
import 'model.dart';


class CreatePostPage extends StatefulWidget  {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {


  TextEditingController _controller_content = TextEditingController();
  TextEditingController _controller_title = TextEditingController();

  @override
  void dispose() {
    _controller_content.dispose();
    _controller_title.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, __) {
        final state = ref.watch(createPostStateNotifierProvider);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant,

              ), onPressed: () { context.pop(); },
            ),
           actions: [
             IconButton(
               icon: Icon(Icons.done,color: Theme.of(context).colorScheme.primary,size: 24.sp,),
               onPressed: () {
                 ref.read(createPostStateNotifierProvider.notifier).postPosts();
                 context.pop(context);
               },
             )
           ],
          ),
          bottomSheet: Container(         /// 底部 工具栏  ==> 选择分区 + 添加图片
            height: 50.sp,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface
            ),
            child: Row(
              children: [
                Container(       /// 选择分区
                  margin: EdgeInsets.symmetric(horizontal: 10.sp),
                  height: 28.sp,
                  width: 85.sp,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(5.sp)
                  ),
                  child: TextButton(
                      onPressed: () => showSelectPostTypeBottomSheet(context, ref),
                      child: Row(
                        children: [
                          Icon(Icons.add,color: Theme.of(context).colorScheme.onSurfaceVariant,),
                          Text("添加分区",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 11.sp,color: Theme.of(context).colorScheme.onSurfaceVariant),)
                        ],
                      )
                  ),
                ),
                Container(       /// 选择图片
                  margin: EdgeInsets.symmetric(horizontal: 0.sp),
                  height: 28.sp,
                  width: 36.sp,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceBright,
                      borderRadius: BorderRadius.circular(5.sp)
                  ),
                  child: TextButton(
                      onPressed: () => insertMarkdownContent("![](https://avatars.githubusercontent.com/u/104672400?v=4)"),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.insert_photo_outlined),
                        ],
                      )
                  ),
                ),
              ]
            )
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                // color: Colors.red
              ),
              child:  Column(    /// 标题 + 正文
                children: [
                  Container(   /// 标题
                    decoration: BoxDecoration(
                      // color: Colors.green
                    ),
                    child: TextField(
                      onChanged: (value) {   /// 更新vm标题
                        ref.read(createPostStateNotifierProvider.notifier).updateTitle(_controller_title.text);
                      },
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontStyle:  FontStyle.normal,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      controller: _controller_title,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(70),
                            width: 2.sp,
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2.sp,
                          ),
                        ),
                        hintText: "输入标题",
                        hintStyle: TextStyle(
                          fontSize: 30.sp,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )

                  ),

                  Container(     /// 正文（markdown）
                    margin: EdgeInsets.symmetric(vertical: 35.sp),
                    decoration: BoxDecoration(
                      // color: Colors.blue
                    ),
                    child: MarkdownAutoPreview(
                      onChanged: (value) {
                        ref.read(createPostStateNotifierProvider.notifier).updateContent(_controller_content.text);
                      },
                      enableToolBar: true,
                      controller: _controller_content,
                      emojiConvert: true,
                      showEmojiSelection: true,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      decoration: InputDecoration(
                        hintText: "输入正文(支持markdown)",
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2.sp,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2.sp,
                          ),
                        ),
                      ),
                      hintText: "### 输入正文(支持markdown)",
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurfaceVariant,),
                        h1: TextStyle(fontSize: 24.sp, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        h2: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        h3: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        h4: TextStyle(fontSize: 15.sp, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        h5: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        code: TextStyle(
                          fontSize: 14.sp,
                          backgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(40),
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: 'Monospace',
                        ),
                      )
                    )
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void insertMarkdownContent(String content) {
    final text = _controller_content.text;
    final selection = _controller_content.selection;

    if (selection != null && selection.isValid) {
      // 在光标位置插入内容
      final newText = text.replaceRange(selection.start, selection.end, content);
      _controller_content.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.start + content.length),
      );
    } else {
      // 没有选中内容，默认追加在末尾
      _controller_content.text += content;
    }
  }


  String _getDisplayText(postType type) {
    switch (type) {
      case postType.question:
        return "question";
      case postType.showcase:
        return "showcase";
      case postType.discussion:
        return "discussion";
    }
  }

  void showSelectPostTypeBottomSheet(BuildContext context, WidgetRef ref) {
    final postTypeValues = postType.values;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: postTypeValues.map((type) {
              return Container(
                width: double.infinity,
                height: 26.sp,
                margin: EdgeInsets.symmetric(vertical: 5.sp),
                decoration: BoxDecoration(
                  // color: Colors.red
                ),
                child: CapsuleTags(
                  tags: [_getDisplayText(type)],
                  tagColors: [
                    tagColorIconenum.tagStyleEnum[_getDisplayText(type)]?[0],
                  ],
                  tagsIcons: [
                    tagColorIconenum.tagStyleEnum[_getDisplayText(type)]?[1],
                  ],
                  onTap: (_,__){
                    ref.read(createPostStateNotifierProvider.notifier).updatePostType(type);
                    context.pop();
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );





  }




}