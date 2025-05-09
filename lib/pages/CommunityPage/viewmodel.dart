import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/api/dataClass/Posts_List_data.dart';
import '../../api/api.dart';
import '../../utils/logger.dart';

class ComListState {
  final List<PostsListDataItem> postsList;
  final bool isLoading;

  ComListState({required this.postsList, this.isLoading = false});
}


class ComListStateNotifier extends StateNotifier<ComListState> {
  ComListStateNotifier() : super(ComListState(postsList: [])) {
    fetchPostsList(); // 初始化的时候自动加载
  }

  Future<void> fetchPostsList() async {
    state = ComListState(isLoading: true, postsList: state.postsList);
    var response = await Api.instance.getPostsList(1);
    if (response != null) {
      state = ComListState(postsList: response, isLoading: false);
    } else {
      state = ComListState(postsList: [], isLoading: false);
    }
  }
}

final ComListStateNotifierProvider = StateNotifierProvider<ComListStateNotifier, ComListState>(
      (ref) => ComListStateNotifier(),
);


/// 标签颜色枚举
class tagColorIconenum  {
  static final Map<String,List> tagStyleEnum= {
    'question': [Color(0xFF7FFFF8),Icons.question_mark_sharp],
    'showcase': [Color(0xFFFFF681),Icons.handyman_outlined],
    'discussion': [Color(0xFFFFABC8),Icons.forum_outlined],
  };
}