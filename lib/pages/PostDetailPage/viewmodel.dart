import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/api/dataClass/Post_Detail_data.dart';
import '../../api/api.dart';

class PostDetailState {
  final PostDetailData postDetail;   ///
  final String postTitle;    /// 文章标题
  final List<PostDetailComments> postComments;  /// 评论列表
  final List<PostDetailContent> postContent;    /// 文章内容
  final bool isLoading;

  PostDetailState({required this.postDetail,required this.postTitle,
    required this.postComments,required this.postContent,
      required this.isLoading});
}

class PostDetailStateNotifier extends StateNotifier<PostDetailState> {
  PostDetailStateNotifier(postId) : super(PostDetailState(postDetail: PostDetailData(),
     postTitle: "", postComments: [], postContent: [] ,isLoading: true)){
    initPostDetailState(postId);
  }

  Future<void> initPostDetailState(String postId) async {
    await fetchPostDetail(postId);
  }

  Future<void> fetchPostDetail(String postId) async {
    state = PostDetailState(postDetail: PostDetailData(),
        postTitle: "", postComments: [], postContent: [] ,isLoading: true);

    final response = await Api.instance.getPostsDetail(postId);
    if (response != null) {
      final PostDetailData _postDetail_Tmp = response;
      state = PostDetailState(postDetail: _postDetail_Tmp,
          postTitle: _postDetail_Tmp.title ?? "",
          postComments: _postDetail_Tmp.comments ?? [],
          postContent: _postDetail_Tmp.content ?? [],isLoading: true);
    }
  }
}

final postDetailNotifierProvider = StateNotifierProvider.family<
    PostDetailStateNotifier,
    PostDetailState,
    String>(
      (ref, postId) {
    final notifier = PostDetailStateNotifier(postId);
    ref.onDispose(() {});
    return notifier;
  },
);
