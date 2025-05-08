/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc0Njc4ODczOCwiaWF0IjoxNzQ2NzAyMzM4LCJqdGkiOiJiODYzN2Q5NTg2ZDQ0ZGZiOTk3MjBkMTA3OWFiZmIyMSIsInVzZXJfaWQiOjF9.C12Uhs9WD9_LBd9s9X0na3SstpPb5rrVXGRt766ZEb4"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ2NzA1OTM4LCJpYXQiOjE3NDY3MDIzMzgsImp0aSI6ImZjYTgxMDEyZjBiYjQyODVhZjRlN2JlNWE2NTU3MGM2IiwidXNlcl9pZCI6MX0.N-Gg5h7J7Qzki-Eravc3Syp7ss6xGAQ936Y4HZTA-ug"

class LoginResData {
  LoginResData({
      String? refresh, 
      String? access,}){
    _refresh = refresh;
    _access = access;
}

  LoginResData.fromJson(dynamic json) {
    _refresh = json['refresh'];
    _access = json['access'];
  }
  String? _refresh;
  String? _access;
LoginResData copyWith({  String? refresh,
  String? access,
}) => LoginResData(  refresh: refresh ?? _refresh,
  access: access ?? _access,
);
  String? get refresh => _refresh;
  String? get access => _access;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = _refresh;
    map['access'] = _access;
    return map;
  }

}