import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/api/dataClass/Post_Detail_data.dart';
import '../../api/api.dart';

class PostDetailState {
  final PostDetailData postDetail;   ///
  final String postTitle;    /// 文章标题
  final List<PostDetailComments> postComments;  /// 评论列表
  final List<PostDetailContent> postContents;    /// 文章内容
  final bool isLoading;

  PostDetailState({required this.postDetail,required this.postTitle,
    required this.postComments,
    required this.postContents,
      required this.isLoading});

}

class PostDetailStateNotifier extends StateNotifier<PostDetailState> {
  PostDetailStateNotifier(postId) : super(PostDetailState(postDetail: PostDetailData(),
     postTitle: "", postComments: [], postContents: [] ,isLoading: true)){
    initPostDetailState(postId);
  }

  Future<void> initPostDetailState(String postId) async {
    await fetchPostDetail(postId);
  }

  Future<void> fetchPostDetail(String postId) async {
    state = PostDetailState(postDetail: PostDetailData(),
        postTitle: "", postComments: [], postContents: [] ,isLoading: true);

    final response = await Api.instance.getPostsDetail(postId);
    if (response != null) {
      final PostDetailData _postDetail_Tmp = response;
      state = PostDetailState(postDetail: _postDetail_Tmp,
          postTitle: _postDetail_Tmp.title ?? "",
          postComments: _postDetail_Tmp.comments ?? [],
          postContents: _postDetail_Tmp.content ?? [], isLoading: false);
    }
  }

}

final postDetailNotifierProvider = AutoDisposeStateNotifierProvider.family<
    PostDetailStateNotifier,
    PostDetailState,
    String>(
      (ref, postId) {
    final notifier = PostDetailStateNotifier(postId);
    return notifier;
  },
);


class CreateCommentsState{
  CreateCommentsState({
    this.isLoading = false,
    this.CommentContents = ""
  });

  final bool isLoading;
  final String ? CommentContents;

  CreateCommentsState copyWith({
    bool? isLoading,
    String? CommentContents,
  }) {
    return CreateCommentsState(
     isLoading: isLoading ?? this.isLoading
          ? true
          : false,
      CommentContents: CommentContents ?? this.CommentContents,
    );
  }
}

class CreateCommentsStateNotifier extends StateNotifier<CreateCommentsState> {
  CreateCommentsStateNotifier() : super(CreateCommentsState());

  void updateCommentContents(String CommentContents) {    /// 更新评论输入
    state = state.copyWith(CommentContents: CommentContents);
  }

  Future<void> submitComment(String postId) async {
    print(state.CommentContents);
    if (state.CommentContents!.isEmpty) {
      return;
    }
    state = state.copyWith(isLoading: true);
    try {
      var response = await Api.instance.createComment(postId, state.CommentContents!);
      if (response.code == 0) {
        state = state.copyWith(isLoading: false);
        state = state.copyWith(CommentContents: "");
        return;
      }
    }catch(e) {
      state = state.copyWith(isLoading: false);
      return;
    }
  }



}

final CreateCommentsStateNotifierProvider = AutoDisposeStateNotifierProvider<CreateCommentsStateNotifier, CreateCommentsState>(
      (ref) => CreateCommentsStateNotifier(),
);
