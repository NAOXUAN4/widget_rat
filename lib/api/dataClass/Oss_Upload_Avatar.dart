/// success : true
/// message : "头像已上传并转换为 PNG 格式"
/// avatar_url : "https://widgetrat-avatars-dev.oss-cn-beijing.aliyuncs.com/avatars/3/avatar.png"
/// status_code : 200
/// content_type : "image/png"

class OssUploadAvatar {
  OssUploadAvatar({
      bool? success, 
      String? message, 
      String? avatarUrl, 
      num? statusCode, 
      String? contentType,}){
    _success = success;
    _message = message;
    _avatarUrl = avatarUrl;
    _statusCode = statusCode;
    _contentType = contentType;
}

  OssUploadAvatar.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _avatarUrl = json['avatar_url'];
    _statusCode = json['status_code'];
    _contentType = json['content_type'];
  }
  bool? _success;
  String? _message;
  String? _avatarUrl;
  num? _statusCode;
  String? _contentType;
OssUploadAvatar copyWith({  bool? success,
  String? message,
  String? avatarUrl,
  num? statusCode,
  String? contentType,
}) => OssUploadAvatar(  success: success ?? _success,
  message: message ?? _message,
  avatarUrl: avatarUrl ?? _avatarUrl,
  statusCode: statusCode ?? _statusCode,
  contentType: contentType ?? _contentType,
);
  bool? get success => _success;
  String? get message => _message;
  String? get avatarUrl => _avatarUrl;
  num? get statusCode => _statusCode;
  String? get contentType => _contentType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['avatar_url'] = _avatarUrl;
    map['status_code'] = _statusCode;
    map['content_type'] = _contentType;
    return map;
  }

}