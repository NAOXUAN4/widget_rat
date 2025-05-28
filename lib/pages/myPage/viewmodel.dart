import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/global.dart';


class MyPageState {
  final bool isLoading;
  final String avatarUrl;   /// 头像图片
  final  String username;
  final String userBio;
  final  num authorid;



  MyPageState({
    this.isLoading = false,
    this.avatarUrl = "",
    this.username = "name",
    this.authorid = 0,
    this.userBio = "Bio",
  });

  MyPageState copyWith({
    bool? isLoading,
    String? avatarUrl,
    String? username,
    num? authorid,
    String? userBio,
  }) {
    return MyPageState(
      isLoading: isLoading ?? this.isLoading,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      username: username ?? this.username,
      authorid: authorid ?? this.authorid,
      userBio: userBio ?? this.userBio,
    );
  }
}




class MyPageNotifier extends StateNotifier<MyPageState> {
  MyPageNotifier() : super(MyPageState(
    avatarUrl: "https://${Global.ossAvatarUrl}${Global.userId}/test_upload.png",
    username: Global.userName ?? "DefaultName",
    authorid: Global.userId ?? 0,
    userBio:  Global.userBio ?? "",
  ));

  final ImagePicker picker = ImagePicker();

  /// 从相册选择图片
  Future<void> pickAvatarFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(
        avatarUrl: image.path,
      );
    }
  }

}

final mypageNotifierProvider = AutoDisposeStateNotifierProvider<MyPageNotifier, MyPageState>(
      (ref) => MyPageNotifier(),
);