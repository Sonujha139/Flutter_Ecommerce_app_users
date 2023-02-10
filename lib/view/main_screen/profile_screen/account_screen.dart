import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/consts/consts.dart';
import 'package:ekart/controller/auth_controller.dart';
import 'package:ekart/controller/profile_controller.dart';
import 'package:ekart/services/firestore_services.dart';
import 'package:ekart/view/auth_screen/Login_Screen.dart';
import 'package:ekart/view/main_screen/profile_screen/components/detail_card.dart';
import 'package:ekart/view/main_screen/profile_screen/edit_profile_screen.dart';
import 'package:ekart/widget/bg_widget.dart';
import 'package:get/get.dart';

import '../../../consts/list.dart';
import '../message_screen/message_screen.dart';
import '../order_screen/order_screen.dart';
import '../wishlist_screen/wishlist_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgwidget(
        child: Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(imgProfile2,
                                    width: 130, height: 90, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(data['imageUrl'],
                                    width: 130, height: 90, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .white
                                .make(),
                            5.heightBox,
                            "${data['email']}".text.white.make()
                          ],
                        )),
                        // OutlinedButton(
                        //     style: OutlinedButton.styleFrom(
                        //         side: BorderSide(color: Appcolors.whiteColor)),
                        //     onPressed: () async {
                        //       await Get.put(AuthController())
                        //           .signoutMethod(context);
                        //       Get.offAll(const LoginScreen());
                        //     },
                        //     child: logout.text.fontFamily(semibold).white.make())
                      ],
                    ),
                  ),
                  20.heightBox,
                  FutureBuilder(
                    future: FirestoreServices.getCounts(),
                    builder: (BuildContext context,
                        AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(Appcolors.redColor),
                        ));
                      } else {
                        var countdata = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detaisCard(
                                width: context.screenWidth / 3.4,
                                count: countdata[0].toString(),
                                title: "in your cart"),
                            detaisCard(
                                width: context.screenWidth / 3.4,
                                count: countdata[1].toString(),
                                title: "in your wishlist"),
                            detaisCard(
                                width: context.screenWidth / 3.4,
                                count: countdata[2].toString(),
                                title: "your orders"),
                          ],
                        ).box.color(Appcolors.redColor).make();
                      }
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detaisCard(
                  //         width: context.screenWidth / 3.4,
                  //         count: data['cart_count'],
                  //         title: "in your cart"),
                  //     detaisCard(
                  //         width: context.screenWidth / 3.4,
                  //         count: data['wishlist_count'],
                  //         title: "in your wishlist"),
                  //     detaisCard(
                  //         width: context.screenWidth / 3.4,
                  //         count: data['order_count'],
                  //         title: "your orders"),
                  //   ],
                  // ).box.color(Appcolors.redColor).make(),

                  // **************************button section***********************************

                  ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Appcolors.lightGrey,
                            );
                          },
                          itemCount: profileButtonList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () async {
                                switch (index) {
                                  case 0:
                                    Get.to(const OrderScreen());
                                    break;
                                  case 1:
                                    Get.to(const WishlistScreen());
                                    break;
                                  case 2:
                                    Get.to(const MessageScreen());
                                    break;

                                  case 3:
                                    controller.nameController.text =
                                        data['name'];
                                    Get.to(EditProfileScreen(data: data));
                                    break;
                                  case 4:
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    Get.offAll(const LoginScreen());
                                    break;
                                  default:
                                }
                              },
                              leading: Image.asset(
                                profileButtonIcon[index],
                                color: Colors.black,
                                width: 22,
                              ),
                              title: profileButtonList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(Appcolors.darkFontGrey)
                                  .make(),
                            );
                          })
                      .box
                      .white
                      .rounded
                      .margin(EdgeInsets.all(12))
                      .shadowSm
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .make()
                      .box
                      .color(Appcolors.redColor)
                      .make()
                ],
              ));
            }
          },
        ),
      ),
    ));
  }
}
