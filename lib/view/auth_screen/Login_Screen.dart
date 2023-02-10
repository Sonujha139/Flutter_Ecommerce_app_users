
import 'package:ekart/consts/consts.dart';
import 'package:ekart/consts/list.dart';
import 'package:ekart/controller/auth_controller.dart';
import 'package:ekart/view/auth_screen/signup_screen.dart';
import 'package:ekart/view/main_screen/BottomNavBar_Screen.dart';
import 'package:ekart/widget/Custom_Textfield.dart';
import 'package:ekart/widget/applogo.dart';
import 'package:ekart/widget/bg_widget.dart';
import 'package:ekart/widget/button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgwidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    (context.screenHeight * 0.1).heightBox,
                    applogoWidget(),
                    10.heightBox,
                    "Login In To $appname"
                        .text
                        .fontFamily(bold)
                        .white
                        .size(18)
                        .make(),
                    15.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          CustomTextField(
                              hint: emailHint,
                              title: email,
                              isPass: false,
                              controller: controller.emailController),
                          CustomTextField(
                              hint: passwordHint,
                              title: password,
                              isPass: true,
                              controller: controller.passwordController),
                          Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: forgotpass.text.make())),
                          5.heightBox,
                          controller.isloading.value
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Appcolors.redColor),
                                )
                              : ourButton(
                                  color: Appcolors.redColor,
                                  title: login,
                                  textColor: Appcolors.whiteColor,
                                  onpress: () async {
                                    controller.isloading(true);
                                    await controller
                                        .loginMethod(context: context)
                                        .then((value) {
                                      if (value != null) {
                                        VxToast.show(context, msg: loggedin);
                                        Get.offAll(
                                            () => const BottomNavBarScreen());
                                      } else {
                                        controller.isloading(false);

                                      }
                                    });
                                  }).box.width(context.screenWidth - 50).make(),
                          5.heightBox,
                          createNewAccount.text
                              .color(Appcolors.fontGrey)
                              .make(),
                          5.heightBox,
                          ourButton(
                              color: Appcolors.lightgolden,
                              title: signup,
                              textColor: Appcolors.redColor,
                              onpress: () {
                                Get.to(() => SignupScreen());
                              }).box.width(context.screenWidth - 50).make(),
                          10.heightBox,
                          loginWith.text.color(Appcolors.fontGrey).make(),
                          5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Appcolors.lightGrey,
                                  radius: 22,
                                  child: Image.asset(
                                    socialIconList[index],
                                    width: 30,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                          .box
                          .white
                          .rounded
                          .padding(const EdgeInsets.all(20))
                          .width(context.screenHeight - 70)
                          .shadowSm
                          .make(),
                    ),
                  ],
                ),
              ),
            )));
  }
}
