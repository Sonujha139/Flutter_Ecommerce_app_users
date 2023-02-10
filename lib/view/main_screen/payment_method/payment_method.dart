import 'package:ekart/consts/consts.dart';
import 'package:ekart/controller/cartController.dart';
import 'package:ekart/view/main_screen/BottomNavBar_Screen.dart';
import 'package:ekart/widget/button.dart';
import 'package:get/get.dart';

import '../../../consts/list.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: Appcolors.whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Appcolors.fontGrey)),
                )
              : ourButton(
                  color: Appcolors.redColor,
                  onpress: () async {
                    await controller.placemyOrder(
                        orderPaymentMethod:
                            paymentMethod[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(const BottomNavBarScreen());
                  },
                  textColor: Appcolors.whiteColor,
                  title: "Place my order",
                ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(Appcolors.darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodImg.length, (index) {
              return GestureDetector(
                onTap: () {
                  controller.changePaymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? Appcolors.redColor
                              : Colors.transparent,
                          width: 3)),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Image.asset(
                          paymentMethodImg[index],
                          width: double.infinity,
                          height: 120,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentMethod[index]
                              .text
                              .fontFamily(semibold)
                              .size(16)
                              .white
                              .make())
                    ],
                  ),
                ),
              );
            })),
          ),
        ),
      ),
    );
  }
}
