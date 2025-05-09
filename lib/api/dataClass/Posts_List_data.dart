/// count : 2
/// next : null
/// previous : null
/// results : [{"id":2,"title":"测试帖子二","author":1,"author_avatar_url":"http://....","post_type":"discussion","upvotes":0,"created_at":"2025-05-05 07:11:46"},{"id":1,"title":"测试帖子一","author":1,"author_avatar_url":"Nanyian","post_type":"discussion","upvotes":0,"created_at":"2025-05-05 07:10:22"}]

class PostsListData {
  PostsListData({
      num? count, 
      dynamic next, 
      dynamic previous, 
      List<PostsListDataItem>? results,}){
    _count = count;
    _next = next;
    _previous = previous;
    _results = results;
}

  PostsListData.fromJson(dynamic json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(PostsListDataItem.fromJson(v));
      });
    }
  }
  num? _count;
  dynamic _next;
  dynamic _previous;
  List<PostsListDataItem>? _results;
PostsListData copyWith({  num? count,
  dynamic next,
  dynamic previous,
  List<PostsListDataItem>? results,
}) => PostsListData(  count: count ?? _count,
  next: next ?? _next,
  previous: previous ?? _previous,
  results: results ?? _results,
);
  num? get count => _count;
  dynamic get next => _next;
  dynamic get previous => _previous;
  List<PostsListDataItem>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['next'] = _next;
    map['previous'] = _previous;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// title : "测试帖子二"
/// author : 1
/// author_avatar_url : "http://...."
/// post_type : "discussion"
/// upvotes : 0
/// created_at : "2025-05-05 07:11:46"

class PostsListDataItem {
  PostsListDataItem({
      num? id, 
      String? title, 
      num? author, 
      String? authorAvatarUrl, 
      String? postType, 
      num? upvotes, 
      String? createdAt,}){
    _id = id;
    _title = title;
    _author = author;
    _authorAvatarUrl = authorAvatarUrl;
    _postType = postType;
    _upvotes = upvotes;
    _createdAt = createdAt;
}

  PostsListDataItem.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _author = json['author'];
    _authorAvatarUrl = json['author_avatar_url'];
    _postType = json['post_type'];
    _upvotes = json['upvotes'];
    _createdAt = json['created_at'];
  }
  num? _id;
  String? _title;
  num? _author;
  String? _authorAvatarUrl;
  String? _postType;
  num? _upvotes;
  String? _createdAt;
PostsListDataItem copyWith({  num? id,
  String? title,
  num? author,
  String? authorAvatarUrl,
  String? postType,
  num? upvotes,
  String? createdAt,
}) => PostsListDataItem(  id: id ?? _id,
  title: title ?? _title,
  author: author ?? _author,
  authorAvatarUrl: authorAvatarUrl ?? _authorAvatarUrl,
  postType: postType ?? _postType,
  upvotes: upvotes ?? _upvotes,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  String? get title => _title;
  num? get author => _author;
  String? get authorAvatarUrl => _authorAvatarUrl;
  String? get postType => _postType;
  num? get upvotes => _upvotes;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['author'] = _author;
    map['author_avatar_url'] = _authorAvatarUrl;
    map['post_type'] = _postType;
    map['upvotes'] = _upvotes;
    map['created_at'] = _createdAt;
    return map;
  }
}