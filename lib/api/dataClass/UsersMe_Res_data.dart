/// id : 1
/// username : "Nanyian"
/// email : ""
/// avatar_url : "https://widgetrat-avatars-dev.oss-cn-beijing.aliyuncs.com/avatars/1/test_upload.png"
/// bio : null
/// github_url : null

class UsersMeResData {
  UsersMeResData({
      num? id, 
      String? username, 
      String? email, 
      String? avatarUrl, 
      dynamic bio, 
      dynamic githubUrl,}){
    _id = id;
    _username = username;
    _email = email;
    _avatarUrl = avatarUrl;
    _bio = bio;
    _githubUrl = githubUrl;
}

  UsersMeResData.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _avatarUrl = json['avatar_url'];
    _bio = json['bio'];
    _githubUrl = json['github_url'];
  }
  num? _id;
  String? _username;
  String? _email;
  String? _avatarUrl;
  dynamic _bio;
  dynamic _githubUrl;
UsersMeResData copyWith({  num? id,
  String? username,
  String? email,
  String? avatarUrl,
  dynamic bio,
  dynamic githubUrl,
}) => UsersMeResData(  id: id ?? _id,
  username: username ?? _username,
  email: email ?? _email,
  avatarUrl: avatarUrl ?? _avatarUrl,
  bio: bio ?? _bio,
  githubUrl: githubUrl ?? _githubUrl,
);
  num? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get avatarUrl => _avatarUrl;
  dynamic get bio => _bio;
  dynamic get githubUrl => _githubUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['avatar_url'] = _avatarUrl;
    map['bio'] = _bio;
    map['github_url'] = _githubUrl;
    return map;
  }

}