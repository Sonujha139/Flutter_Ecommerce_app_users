import 'dart:io';
import 'package:get/get.dart';

import '../../../consts/consts.dart';
import '../../../controller/profile_controller.dart';
import '../../../widget/Custom_Textfield.dart';
import '../../../widget/bg_widget.dart';
import '../../../widget/button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgwidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Obx(
        () => Column(mainAxisSize: MainAxisSize.min, children: [
          // if data image url and controller path is empty
          data['imageUrl'] == '' && controller.profileImgPath.isEmpty
              ? Image.asset(imgProfile2, width: 100,height: 65, fit: BoxFit.cover)
                  .box
                  .roundedFull
                  .clip(Clip.antiAlias)
                  .make()

              //if data is not empty but controller path is empty
              : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                  ? Image.network(
                      data['imageUrl'],
                      width: 100,height: 65,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()

                  //if both are empty
                  : Image.file(
                      File(controller.profileImgPath.value),
                      width: 100,
                      height: 65,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
          10.heightBox,
          ourButton(
              color: Appcolors.redColor,
              onpress: () {
                controller.changeImage(context);
              },
              textColor: Appcolors.whiteColor,
              title: "Change"),
          const Divider(),
          20.heightBox,
          CustomTextField(
            controller: controller.nameController,
            hint: nameHint,
            title: name,
            isPass: false,
          ),
          10.heightBox,
          CustomTextField(
            controller: controller.oldpassController,
            hint: passwordHint,
            title: oldpass,
            isPass: true,
          ),
          10.heightBox,
          CustomTextField(
            controller: controller.newpassController,
            hint: passwordHint,
            title: newpass,
            isPass: true,
          ),
          20.heightBox,
          controller.isloading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.redColor),
                )
              : SizedBox(
                  width: context.screenWidth - 60,
                  child: ourButton(
                      color: Appcolors.redColor,
                      onpress: () async {
                        controller.isloading(true);

                        //if image os not selected
                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImageLink = data['imageUrl'];
                        }

                        // if old password matches database

                        if (data['password'] ==
                            controller.oldpassController.text) {
                         await controller.changeAuthPassword(email: data['email'], password: controller.oldpassController.text, newpassword: controller.newpassController.text);

                          await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              name: controller.nameController.text,
                              password: controller.newpassController.text);
                          VxToast.show(context, msg: "Updated");
                        }  else if (controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull){
                             await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: data['password']);
                            VxToast.show(context, msg: "Updated");
                            controller.isloading(false);
                          }else{
                            VxToast.show(context, msg: "Some error occured");
                            controller.isloading(false);
                          }
                      },
                      textColor: Appcolors.whiteColor,
                      title: "Save"),
                ),
        ])
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .rounded
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}
