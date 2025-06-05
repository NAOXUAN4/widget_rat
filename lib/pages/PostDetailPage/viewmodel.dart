import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_rat/api/dataClass/Post_Detail_data.dart';
import '../../api/api.dart';
import 'model.dart';



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


/// 评论状态

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
