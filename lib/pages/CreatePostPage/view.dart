import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markdown_editor_plus/widgets/markdown_auto_preview.dart';
import 'package:oktoast/oktoast.dart';


class CreatePostPage extends StatefulWidget  {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       actions: [
         IconButton(
           icon: Icon(Icons.send),
           onPressed: () {
             Navigator.pop(context);
           },
         )
       ],
      ),
      body: Container(
        decoration: BoxDecoration(

        ),
        child:  Column(    /// 标题 + 正文
          children: [
            Container(
              child: MarkdownAutoPreview(
                controller: _controller,
                emojiConvert: true,
                showEmojiSelection: true,
                hintText: "输入标题",
              )
            ),
            Container(),
          ],
        ),
      ),
    );
  }



}