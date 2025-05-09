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
  var _pageNow  = 1;   /// 初始当前页码
  bool _hasMore = true;

  ComListStateNotifier() : super(ComListState(postsList: [])) {
    initComListState();   /// 初始化ComListState
  }

  Future<void> initComListState() async {
    await fetchPostsList(isRefresh: true);
  }

  Future<void> fetchPostsList({bool isRefresh = false}) async {
    if(isRefresh){
      _pageNow = 1;
      _hasMore = true;
    }
    if (!_hasMore) {
      return;
    }

    final response = await Api.instance.getPostsList(_pageNow);  // 获取数据

    if (response != null && response.isNotEmpty) {
      if(isRefresh){
        state = ComListState(postsList: response, isLoading: false);  // postList = Page1
      }else{
        state = ComListState(
            postsList: [... state.postsList, ...response],
            isLoading: false
        );
      }
      _pageNow++;
      _hasMore = response.length == 10;   // 如果返回的数据长度为10，则还有更多数据，否则没有更多数据
    }else{
      _hasMore = false;
      state = ComListState(postsList: state.postsList, isLoading: false);
    }
  }
}

final ComListStateNotifierProvider = StateNotifierProvider<ComListStateNotifier, ComListState>(
      (ref) => ComListStateNotifier(),
);


