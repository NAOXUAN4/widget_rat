/// accessKeyId : "STS.NVBYketHgputwvAQTE8EXW6AW"
/// accessKeySecret : "7DqgJuEJYDAEZjU8hV6H7cn1eNcKQk93D34peFK7wHwm"
/// securityToken : "CAIStwN1q6Ft5B2yfSjIr5X3EtHRmZdGx7efdVDwtVQQNMp0uPPqtTz2IHhMenZtBOobtv0ynmxZ5vYalrtsSpNKSFDeZNc184xT9gqtJtOZCzAvWCde2vOfAmG2J0PRBqagpIybIfrZfvCyEQ6m8gZ43br9cxi7QlWhKufnoJV7b9MRLH/aCD1dH4VuOxdFos0XPmezUPG2KUzFj3b3BkhlsRYGjwEZ06mkxdCG4RfzlUDzzvRvx778OZ+5dcJhTq0dFt6+x75xbbGTknwSuQdL+Kh7kLZN5XLOoNiBCkNKphmLLa3d7NRzJRViIfF9WcwNpfPnx/pjob6Rxcal1BdBMuxJSS3DAYm+ydfNAvjsOtsnV86iaiyUiorSbcSs71N9Oy5EDm4QJYp9cE0XIAc3VzTXJpWg/F33eQq5Q8CHqvpuicQqkgiyoILTegLTEuXJiTxiJZ4wYE40LRcKmGv6aeocdAhBY6TgzXhyul0Yhnl+3kCI1WW6PkUIpvqHZuhMklT4kJS+eFfen2N3IJucXu4yl0EAYTqZNRwgZAkaWpJLz57sYJMEEH5SC5ZlaQziCZjDyzha0j0yGoABOKLgD2sS3wS+vdSvIPQ7BDbrCPlKSkc5S/4tOhzAhBqKQtbhfZjkfnQUjM+E2XYpRWALJcdIKkF7bkRQsS8CXYzkkT+moF5ApcUx8oDKqFoCfDs5euT0JOAAFDMLFI56PoixdQ9pmblv+MrctbAMgvzGaqiJ0Nf+qTrH9xSfx24gAA=="
/// endpoint : "oss-cn-beijing.aliyuncs.com"
/// bucket : "widgetrat-avatars-dev"
/// prefix : "avatars/1/"

class OssTmpAccessData {
  OssTmpAccessData({
      String? accessKeyId, 
      String? accessKeySecret, 
      String? securityToken, 
      String? endpoint, 
      String? bucket, 
      String? prefix,}){
    _accessKeyId = accessKeyId;
    _accessKeySecret = accessKeySecret;
    _securityToken = securityToken;
    _endpoint = endpoint;
    _bucket = bucket;
    _prefix = prefix;
}

  OssTmpAccessData.fromJson(dynamic json) {
    _accessKeyId = json['accessKeyId'];
    _accessKeySecret = json['accessKeySecret'];
    _securityToken = json['securityToken'];
    _endpoint = json['endpoint'];
    _bucket = json['bucket'];
    _prefix = json['prefix'];
  }
  String? _accessKeyId;
  String? _accessKeySecret;
  String? _securityToken;
  String? _endpoint;
  String? _bucket;
  String? _prefix;
OssTmpAccessData copyWith({  String? accessKeyId,
  String? accessKeySecret,
  String? securityToken,
  String? endpoint,
  String? bucket,
  String? prefix,
}) => OssTmpAccessData(  accessKeyId: accessKeyId ?? _accessKeyId,
  accessKeySecret: accessKeySecret ?? _accessKeySecret,
  securityToken: securityToken ?? _securityToken,
  endpoint: endpoint ?? _endpoint,
  bucket: bucket ?? _bucket,
  prefix: prefix ?? _prefix,
);
  String? get accessKeyId => _accessKeyId;
  String? get accessKeySecret => _accessKeySecret;
  String? get securityToken => _securityToken;
  String? get endpoint => _endpoint;
  String? get bucket => _bucket;
  String? get prefix => _prefix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessKeyId'] = _accessKeyId;
    map['accessKeySecret'] = _accessKeySecret;
    map['securityToken'] = _securityToken;
    map['endpoint'] = _endpoint;
    map['bucket'] = _bucket;
    map['prefix'] = _prefix;
    return map;
  }

}