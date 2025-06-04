class Global {
  static String? ossUrl; // OSS 基础路径
  static String? ossAvatarUrl;

  static num? userId;
  static String? userName;
  static String? userBio;


  static String? userAvatarPath = "https://${Global.ossAvatarUrl}${Global.userId}/test_upload.png";

  static bool isLogin = false;


}
