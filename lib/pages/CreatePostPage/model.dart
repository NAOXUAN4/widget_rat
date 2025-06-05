enum  postType{
  question,
  showcase,
  discussion
}

String parsePostType(postType value) {
  switch (value) {
    case postType.question:
      return "question";
    case postType.showcase:
      return "showcase";
    case postType.discussion:
      return "discussion";
    default:
      return "discussion";
  }
}

class CreatePostState{
  final String title;
  final String content;
  final postType post_type;

  CreatePostState({this.title = '', this.content = '', this.post_type = postType.discussion});
}