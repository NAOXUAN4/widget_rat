/// bio : "你好"
/// github_url : "https://1.github.com"
/// email : "2947@qq.com"

class UpdateMeData {
  UpdateMeData({
      String? bio, 
      String? githubUrl, 
      String? email,}){
    _bio = bio;
    _githubUrl = githubUrl;
    _email = email;
}

  UpdateMeData.fromJson(dynamic json) {
    _bio = json['bio'];
    _githubUrl = json['github_url'];
    _email = json['email'];
  }
  String? _bio;
  String? _githubUrl;
  String? _email;
UpdateMeData copyWith({  String? bio,
  String? githubUrl,
  String? email,
}) => UpdateMeData(  bio: bio ?? _bio,
  githubUrl: githubUrl ?? _githubUrl,
  email: email ?? _email,
);
  String? get bio => _bio;
  String? get githubUrl => _githubUrl;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bio'] = _bio;
    map['github_url'] = _githubUrl;
    map['email'] = _email;
    return map;
  }

}