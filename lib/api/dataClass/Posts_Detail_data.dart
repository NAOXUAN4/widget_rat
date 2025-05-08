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
/// comments : [{"id":1,"post":2,"author":1,"author_username":"Nanyian","content":"挺好的挺好的","created_at":"2025-05-08 16:42:39","parent_comment":null},{"id":2,"post":2,"author":1,"author_username":"Nanyian","content":"挺好的挺好的222","created_at":"2025-05-08 16:42:47","parent_comment":null},{"id":3,"post":2,"author":1,"author_username":"Nanyian","content":"挺好的挺好的333","created_at":"2025-05-08 16:42:57","parent_comment":2}]

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
      List<Comments>? comments,}){
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
        _comments?.add(Comments.fromJson(v));
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
  List<Comments>? _comments;
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
  List<Comments>? comments,
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
  List<Comments>? get comments => _comments;

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

/// id : 1
/// post : 2
/// author : 1
/// author_username : "Nanyian"
/// content : "挺好的挺好的"
/// created_at : "2025-05-08 16:42:39"
/// parent_comment : null

class Comments {
  Comments({
      num? id, 
      num? post, 
      num? author, 
      String? authorUsername, 
      String? content, 
      String? createdAt, 
      dynamic parentComment,}){
    _id = id;
    _post = post;
    _author = author;
    _authorUsername = authorUsername;
    _content = content;
    _createdAt = createdAt;
    _parentComment = parentComment;
}

  Comments.fromJson(dynamic json) {
    _id = json['id'];
    _post = json['post'];
    _author = json['author'];
    _authorUsername = json['author_username'];
    _content = json['content'];
    _createdAt = json['created_at'];
    _parentComment = json['parent_comment'];
  }
  num? _id;
  num? _post;
  num? _author;
  String? _authorUsername;
  String? _content;
  String? _createdAt;
  dynamic _parentComment;
Comments copyWith({  num? id,
  num? post,
  num? author,
  String? authorUsername,
  String? content,
  String? createdAt,
  dynamic parentComment,
}) => Comments(  id: id ?? _id,
  post: post ?? _post,
  author: author ?? _author,
  authorUsername: authorUsername ?? _authorUsername,
  content: content ?? _content,
  createdAt: createdAt ?? _createdAt,
  parentComment: parentComment ?? _parentComment,
);
  num? get id => _id;
  num? get post => _post;
  num? get author => _author;
  String? get authorUsername => _authorUsername;
  String? get content => _content;
  String? get createdAt => _createdAt;
  dynamic get parentComment => _parentComment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['post'] = _post;
    map['author'] = _author;
    map['author_username'] = _authorUsername;
    map['content'] = _content;
    map['created_at'] = _createdAt;
    map['parent_comment'] = _parentComment;
    return map;
  }

}