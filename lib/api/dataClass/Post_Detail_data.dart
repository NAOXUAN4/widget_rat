/// id : 1
/// title : "Post1"
/// content : [{"type":"text","value":"..."},{"type":"image","url":"..."}]
/// author : 1
/// author_username : "Nanyian"
/// post_type : "discussion"
/// tool : null
/// created_at : "2025-05-10 12:18:30"
/// updated_at : "2025-05-10 12:18:30"
/// upvotes : 0
/// comments : [{"id":1,"post":1,"author":1,"author_username":"Nanyian","content":"不错不错","created_at":"2025-05-10 12:22:29","parent_comment":null},{"id":2,"post":1,"author":1,"author_username":"Nanyian","content":"不错不错222","created_at":"2025-05-10 12:22:41","parent_comment":1}]

class PostDetailData {
  PostDetailData({
      num? id,
      String? title,
      List<PostDetailContent>? content,
      num? author,
      String? authorUsername,
      String? postType,
      dynamic tool,
      String? createdAt,
      String? updatedAt,
      num? upvotes,
      List<PostDetailComments>? comments,}){
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

  PostDetailData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    if (json['content'] != null) {
      _content = [];
      json['content'].forEach((v) {
        _content?.add(PostDetailContent.fromJson(v));
      });
    }
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
        _comments?.add(PostDetailComments.fromJson(v));
      });
    }
  }
  num? _id;
  String? _title;
  List<PostDetailContent>? _content;
  num? _author;
  String? _authorUsername;
  String? _postType;
  dynamic _tool;
  String? _createdAt;
  String? _updatedAt;
  num? _upvotes;
  List<PostDetailComments>? _comments;
PostDetailData copyWith({  num? id,
  String? title,
  List<PostDetailContent>? content,
  num? author,
  String? authorUsername,
  String? postType,
  dynamic tool,
  String? createdAt,
  String? updatedAt,
  num? upvotes,
  List<PostDetailComments>? comments,
}) => PostDetailData(  id: id ?? _id,
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
  List<PostDetailContent>? get content => _content;
  num? get author => _author;
  String? get authorUsername => _authorUsername;
  String? get postType => _postType;
  dynamic get tool => _tool;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get upvotes => _upvotes;
  List<PostDetailComments>? get comments => _comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
    }
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
/// post : 1
/// author : 1
/// author_username : "Nanyian"
/// content : "不错不错"
/// created_at : "2025-05-10 12:22:29"
/// parent_comment : null

class PostDetailComments {
  PostDetailComments({
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

  PostDetailComments.fromJson(dynamic json) {
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
PostDetailComments copyWith({  num? id,
  num? post,
  num? author,
  String? authorUsername,
  String? content,
  String? createdAt,
  dynamic parentComment,
}) => PostDetailComments(  id: id ?? _id,
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

/// type : "text"
/// value : "..."

class PostDetailContent {
  PostDetailContent({
      String? type,
      String? value,}){
    _type = type;
    _value = value;
}

  PostDetailContent.fromJson(dynamic json) {
    _type = json['type'];
    _value = json['value'];
  }
  String? _type;
  String? _value;
PostDetailContent copyWith({  String? type,
  String? value,
}) => PostDetailContent(  type: type ?? _type,
  value: value ?? _value,
);
  String? get type => _type;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['value'] = _value;
    return map;
  }

}