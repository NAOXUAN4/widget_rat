import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:widget_rat/api/dataClass/Update_Me_data.dart';
import 'package:widget_rat/utils/logger.dart';

import '../../api/api.dart';
import '../../utils/global.dart';
import 'model.dart';




bool isValidEmail(String? email) {
  if (!(email == null || email.isEmpty)) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  return true;
}

class MyPageNotifier extends StateNotifier<MyPageState> {
  MyPageNotifier() : super(MyPageState(
    avatarUrl: Global.userAvatarPath ?? "",
    username: Global.userName ?? "DefaultName",
    authorid: Global.userId ?? 0,
    userBio:  Global.userBio ?? "",
    avatarTmp: Global.userAvatarPath ?? "",
  ));

  final ImagePicker picker = ImagePicker();

  /// 从相册选择图片
  Future<void> pickAvatarFromGallery() async {
    if (state.isLoading) return;
    state = state.copyWith(
      isLoading: true,
    );
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(
        avatarTmp: image.path,
        isLoading: false,
      );
    }
  }


  /// api/update/me 调用 更新个人信息接口
  Future<void> updateMe() async {
    if(state.isLoading){logger.d("isLoading Locked"); return;}

    state = state.copyWith(isLoading: true);
    try{
      final Map<String, dynamic> updateData = {};

      if (state.editEmail.trim().isNotEmpty) {
        if(isValidEmail(state.editEmail)) {
          updateData['email'] = state.editEmail.trim();
        }

      }

      if (state.editBio.trim().isNotEmpty) {
        updateData['bio'] = state.editBio.trim();
      }

      if (state.editGithubUrl.trim().isNotEmpty) {
        updateData['github_url'] = state.editGithubUrl.trim();
      }

      if (updateData.isEmpty) {
        logger.d("没有需要更新的内容");
        state = state.copyWith(isLoading: false);
        return;
      }

      final response = await Api.instance.updateMe(updateData);

    }catch(e){
      logger.d("updateMeApiFailed! ", error: e);
    }
    state = state.copyWith(isLoading: false);
  }

  /// 更新输入框
  void updateEditContent(String textFieldContent, num editType){
    if(editType == 0){
      state = state.copyWith(editEmail: textFieldContent);
    }else if(editType == 1){
      state = state.copyWith(editBio: textFieldContent);
    }
  }

}

final mypageNotifierProvider = AutoDisposeStateNotifierProvider<MyPageNotifier, MyPageState>(
      (ref) => MyPageNotifier(),
);