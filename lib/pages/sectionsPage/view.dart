import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SectionsPageState();
  }
}

class _SectionsPageState extends State<SectionsPage> {

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
        child: Text("SectionsPage"),
      ),
    );
  }
}