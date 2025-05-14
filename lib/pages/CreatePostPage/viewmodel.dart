import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api/api.dart';
import '../../api/dataClass/Post_Detail_data.dart';
import '../../utils/logger.dart';

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

class CreatePostNotifier extends StateNotifier<CreatePostState>{
  CreatePostNotifier(): super(CreatePostState());

  /// 向端口发送请求
  Future postPosts() async{
    PostDetailContent createPostContent = PostDetailContent(type:"text", value: state.content);
    List<Map<String, dynamic>> createPostContentList = [createPostContent.toJson()];

    if(!state.content.isEmpty && !state.title.isEmpty){
      var response = await Api.instance.postPosts(
          state.title,
          createPostContentList,
          parsePostType(state.post_type));
    }else{
      logger.e("标题或内容不能为空");
    }
  }


  /// 更新标题
  void updateTitle(String title){
    state = CreatePostState(title: title, content: state.content, post_type: state.post_type);
  }

  /// 更新内容
  void updateContent(String content){
    state = CreatePostState(title: state.title, content: content, post_type: state.post_type);
  }

  /// 更新类型
  void updatePostType(postType post_type) {
    state = CreatePostState(title: state.title, content: state.content, post_type: post_type);
  }


}


final createPostStateNotifierProvider = AutoDisposeStateNotifierProvider<CreatePostNotifier, CreatePostState>(
    (ref) => CreatePostNotifier(),
);
