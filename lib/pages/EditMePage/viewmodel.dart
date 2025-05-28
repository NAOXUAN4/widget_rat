import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditMeState{
  final  String avatarUrl;
  final  String username;


  EditMeState({
    required this.avatarUrl,
    required this.username,
  });

  EditMeState copyWith({
    String? avatarUrl,
    String? username,
  }) {
    return EditMeState(
      avatarUrl:  this.avatarUrl,
      username:  this.username,

    );
  }


}




class EditMeNotifier extends StateNotifier<EditMeState> {
  EditMeNotifier(): super(EditMeState(
    avatarUrl: "",
    username: "",
  ));





}