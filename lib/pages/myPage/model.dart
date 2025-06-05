class MyPageState {
  final bool isLoading;
  final String avatarUrl;   /// 头像图片
  final String avatarTmp;
  final  String username;
  final String userBio;
  final  num authorid;

  final String editEmail;
  final String editGithubUrl;
  final String editBio;

  MyPageState({
    this.isLoading = false,
    this.avatarUrl = "",
    this.username = "name",
    this.authorid = 0,
    this.userBio = "Bio",
    this.avatarTmp = "",
    this.editBio  = "",
    this.editEmail = "",
    this.editGithubUrl = "",
  });

  MyPageState copyWith({
    bool? isLoading,
    String? avatarUrl,
    String? username,
    num? authorid,
    String? userBio,
    String? avatarTmp,

    String? editEmail,
    String? editGithubUrl,
    String? editBio,

  }) {
    return MyPageState(
      isLoading: isLoading ?? this.isLoading,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      username: username ?? this.username,
      authorid: authorid ?? this.authorid,
      userBio: userBio ?? this.userBio,
      avatarTmp: avatarTmp ?? this.avatarTmp,
      editEmail: editEmail ?? this.editEmail,
      editGithubUrl: editGithubUrl ?? this.editGithubUrl,
      editBio: editBio ?? this.editBio,
    );
  }
}