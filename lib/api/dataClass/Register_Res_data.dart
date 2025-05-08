/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0Njc5MzQxOSwiaWF0IjoxNzQ2NzA3MDE5LCJqdGkiOiI1ZjQwOWYxOWE4MWU0Zjg0YWYyZTlmNmUyNjgxMzZkNiIsInVzZXJfaWQiOjN9.p9C4oOliu623jCOYkQObYEB9O-OCs3oQCckX5ypj020"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2NzEwNjE5LCJpYXQiOjE3NDY3MDcwMTksImp0aSI6ImNmYzFmYWVmODJjNzQ0ZjRiOTA2Nzk3ZThjZTcyNjJlIiwidXNlcl9pZCI6M30.763zb24u1Ix5AmRW3tyCmzAIFQJv6sHi3Fd3m6FlijI"
/// user : {"id":3,"username":"Nanyian3","email":"","avatar_url":null,"bio":null,"github_url":null}

class RegisterResData {
  RegisterResData({
      String? refresh, 
      String? access, 
      User? user,}){
    _refresh = refresh;
    _access = access;
    _user = user;
}

  RegisterResData.fromJson(dynamic json) {
    _refresh = json['refresh'];
    _access = json['access'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? _refresh;
  String? _access;
  User? _user;
RegisterResData copyWith({  String? refresh,
  String? access,
  User? user,
}) => RegisterResData(  refresh: refresh ?? _refresh,
  access: access ?? _access,
  user: user ?? _user,
);
  String? get refresh => _refresh;
  String? get access => _access;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = _refresh;
    map['access'] = _access;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 3
/// username : "Nanyian3"
/// email : ""
/// avatar_url : null
/// bio : null
/// github_url : null

class User {
  User({
      num? id, 
      String? username, 
      String? email,
      String? avatarUrl,
      String? bio,
      String? githubUrl,}){
    _id = id;
    _username = username;
    _email = email;
    _avatarUrl = avatarUrl;
    _bio = bio;
    _githubUrl = githubUrl;
}

  User.fromJson(dynamic json) {
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
  String? _bio;
  String? _githubUrl;
User copyWith({  num? id,
  String? username,
  String? email,
  String? avatarUrl,
  String? bio,
  String? githubUrl,
}) => User(  id: id ?? _id,
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
  String? get bio => _bio;
  String? get githubUrl => _githubUrl;

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