import '../../api/dataClass/Post_Detail_data.dart';

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