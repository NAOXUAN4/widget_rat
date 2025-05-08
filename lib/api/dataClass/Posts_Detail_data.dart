/// id : 2
/// title : "测试帖子二"
/// content : "帖子正文帖子正文帖子正文帖子正文帖子正文"
/// author : 1
/// author_username : "Nanyian"
/// post_type : "discussion"
/// tool : null
/// created_at : "2025-05-05 07:11:46"
/// updated_at : "2025-05-05 07:11:46"
/// upvotes : 0
/// comments : []

class PostsDetailData {
  PostsDetailData({
      num? id, 
      String? title, 
      String? content, 
      num? author, 
      String? authorUsername, 
      String? postType, 
      dynamic tool, 
      String? createdAt, 
      String? updatedAt, 
      num? upvotes, 
      List<dynamic>? comments,}){
    _id = id;
    _title = title;
    _content = content;
    _author = author;
    _authorUsername = authorUsername;
    _postType = postType;
    _tool = tool;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _upvotes = upvotes;
    _comments = comments;
}

  PostsDetailData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _content = json['content'];
    _author = json['author'];
    _authorUsername = json['author_username'];
    _postType = json['post_type'];
    _tool = json['tool'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _upvotes = json['upvotes'];
    if (json['comments'] != null) {
      _comments = [];
      json['comments'].forEach((v) {
        _comments?.add(Dynamic.fromJson(v));
      });
    }
  }
  num? _id;
  String? _title;
  String? _content;
  num? _author;
  String? _authorUsername;
  String? _postType;
  dynamic _tool;
  String? _createdAt;
  String? _updatedAt;
  num? _upvotes;
  List<dynamic>? _comments;
PostsDetailData copyWith({  num? id,
  String? title,
  String? content,
  num? author,
  String? authorUsername,
  String? postType,
  dynamic tool,
  String? createdAt,
  String? updatedAt,
  num? upvotes,
  List<dynamic>? comments,
}) => PostsDetailData(  id: id ?? _id,
  title: title ?? _title,
  content: content ?? _content,
  author: author ?? _author,
  authorUsername: authorUsername ?? _authorUsername,
  postType: postType ?? _postType,
  tool: tool ?? _tool,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  upvotes: upvotes ?? _upvotes,
  comments: comments ?? _comments,
);
  num? get id => _id;
  String? get title => _title;
  String? get content => _content;
  num? get author => _author;
  String? get authorUsername => _authorUsername;
  String? get postType => _postType;
  dynamic get tool => _tool;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get upvotes => _upvotes;
  List<dynamic>? get comments => _comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['content'] = _content;
    map['author'] = _author;
    map['author_username'] = _authorUsername;
    map['post_type'] = _postType;
    map['tool'] = _tool;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['upvotes'] = _upvotes;
    if (_comments != null) {
      map['comments'] = _comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}