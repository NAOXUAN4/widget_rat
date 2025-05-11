/// oss_base_url : "widgetrat-avatars-dev.oss-cn-beijing.aliyuncs.com/"
/// oss_avatar_url : "widgetrat-avatars-dev.oss-cn-beijing.aliyuncs.com/avatars/"

class OssBaseUrlData {
  OssBaseUrlData({
      String? ossBaseUrl, 
      String? ossAvatarUrl,}){
    _ossBaseUrl = ossBaseUrl;
    _ossAvatarUrl = ossAvatarUrl;
}

  OssBaseUrlData.fromJson(dynamic json) {
    _ossBaseUrl = json['oss_base_url'];
    _ossAvatarUrl = json['oss_avatar_url'];
  }
  String? _ossBaseUrl;
  String? _ossAvatarUrl;
OssBaseUrlData copyWith({  String? ossBaseUrl,
  String? ossAvatarUrl,
}) => OssBaseUrlData(  ossBaseUrl: ossBaseUrl ?? _ossBaseUrl,
  ossAvatarUrl: ossAvatarUrl ?? _ossAvatarUrl,
);
  String? get ossBaseUrl => _ossBaseUrl;
  String? get ossAvatarUrl => _ossAvatarUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['oss_base_url'] = _ossBaseUrl;
    map['oss_avatar_url'] = _ossAvatarUrl;
    return map;
  }

}