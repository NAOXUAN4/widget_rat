import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/pages/HomePage/viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homePageNotifierProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Monitor"),
      ),
      body: Center(
        child: Text("Home"),
      )
    );
  }
}