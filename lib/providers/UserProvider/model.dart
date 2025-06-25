class User {
  /// 系统数据 <oss\path>
  final String? ossUrl; // OSS 基础路径
  final String? ossAvatarUrl;

  /// 用户 me 数据
  final num? userId;
  final String? userName;
  final String? userBio;
  final String? userAvatarPath;  // = "https://";   //https://${ossAvatarUrl}${userId}/avatar.png

  /// 系统状态
  final bool? loginStatus; // = false;
  final bool? isLoading;

  User({
    required this.ossUrl,
    required this.ossAvatarUrl,

    this.userId,
    this.userName,
    this.userBio,
    this.userAvatarPath,

    required this.loginStatus,
    required this.isLoading,
  });

  User copyWith({
    String? ossUrl, // OSS 基础路径
    String? ossAvatarUrl,
    num? userId,
    String? userName,
    String? userBio,
    String? userAvatarPath,  // =
    bool? loginStatus, // = false;
    bool? isLoading,
  }) {
    return User(
      ossUrl: ossUrl ?? this.ossUrl,
      ossAvatarUrl: ossAvatarUrl ?? this.ossAvatarUrl,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userBio: userBio ?? this.userBio,
      userAvatarPath: userAvatarPath ?? this.userAvatarPath,
      loginStatus: loginStatus ?? this.loginStatus,
      isLoading:  isLoading ?? this.isLoading
    );
  }
}
