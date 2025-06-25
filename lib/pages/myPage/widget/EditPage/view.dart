import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:widget_rat/pages/myPage/viewmodel.dart';

import '../../../../utils/global.dart';
import '../../../../utils/logger.dart';
import '../../../../widgets/avatar_Container/avatar_Container.dart';


class EditMePage extends StatefulWidget {
  const EditMePage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditMePage();
  }
}

class _EditMePage extends State<EditMePage>{

  late final TextEditingController _editEmailController = TextEditingController();
  late final TextEditingController _editBioController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _editEmailController.dispose();
    _editBioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _router = GoRouter.of(context);
    // logger.d('当前路由名称: ${_router.routeInformationProvider.value.uri}');
    final _formKey = GlobalKey<FormState>();

    // final state = ref.watch(mypageNotifierProvider);   /// 共用的mypage数据
    return Consumer(
      builder: (context,ref,_) {
        final state = ref.watch(mypageNotifierProvider);
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            // title: const Text('Edit Info'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded ),
              onPressed: (){
                context.pop();
              },
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 头像部分
                  Center(
                    child: Stack(
                      children: [
                        AvatarContainer(
                          size: 50.sp,
                          avatarImg: state.avatarTmp.isNotEmpty
                              ? (state.avatarTmp.startsWith("http")
                              ? NetworkImage(state.avatarTmp) as ImageProvider
                              : FileImage(File(state.avatarTmp)))
                              : const AssetImage("assets/images/default_avatar.png"),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              ref.read(mypageNotifierProvider.notifier).pickAvatarFromGallery();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 表单部分
                  const Text('Edit Email', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller:  _editEmailController,
                    validator: (value) {
                      if (!isValidEmail(value)) {
                        return 'Format is not Valid';
                      }
                      return null;
                    },
                    onChanged: (value){
                      ref.read(mypageNotifierProvider.notifier).updateEditContent(_editEmailController.text,0);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter the email',
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text('Edit Bio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _editBioController,

                    onChanged: (value){
                      ref.read(mypageNotifierProvider.notifier).updateEditContent(_editBioController.text,1);
                    },
                    maxLength:  20,
                    // textInputAction:  TextInputAction.done,
                    // maxLines: 3,
                    decoration: InputDecoration(
                      hintText: state.userBio.isEmpty ? 'Enter the Bio' : state.userBio,
                    ),
                  ),
                  SizedBox(height: 16),

                  // const Text('Github Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     hintText: 'Please enter the new Github Link ',
                  //   ),
                  // ),
                  SizedBox(height: 60.sp),

                  // 保存按钮
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) { /// Form 包裹正确性检测
                          ref.read(mypageNotifierProvider.notifier).updateMe().then((value){
                            ref.read(mypageNotifierProvider.notifier).refreshAfterUpdateMe(ref).then((v){
                              // logger.d(Global.userBio);
                              context.pop();
                            });
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Icon(Icons.check,size: 20.sp,color: Theme.of(context).colorScheme.surface,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

}