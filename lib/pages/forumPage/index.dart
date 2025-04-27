import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ForumPageState();
  }
}

class _ForumPageState extends State<ForumPage> {

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitor"),
      ),
      body: Center(
        child: Text("ForumPage"),
      ),
    );
  }
}