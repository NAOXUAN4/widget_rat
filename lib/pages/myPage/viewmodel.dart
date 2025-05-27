import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';


class MyPageState {
  final bool isLoading;
  final String avatarUrl;   /// 头像图片


  MyPageState({
    this.isLoading = false,
    this.avatarUrl = "https://avatars.githubusercontent.com/u/104672400?v=4",
  });

  MyPageState copyWith({
    bool? isLoading,
    String? avatarUrl,
  }) {
    return MyPageState(
      isLoading: isLoading ?? this.isLoading,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}




class MyPageNotifier extends StateNotifier<MyPageState> {
  MyPageNotifier() : super(MyPageState());

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