import 'package:ekart/consts/consts.dart';
import 'package:ekart/controller/cartController.dart';
import 'package:ekart/view/main_screen/payment_method/payment_method.dart';
import 'package:ekart/widget/Custom_Textfield.dart';
import 'package:ekart/widget/button.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Appcolors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(Appcolors.darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: Appcolors.redColor,
          onpress: () {
            if (controller.addressController.text.length > 7 ||
                controller.cityController.text.length > 4 ||
                controller.stateController.text.length > 3 ||
                controller.countryController.text.length > 5 ||
                controller.postalcodeController.text.length > 4 ||
                controller.phoneController.text.length > 10) {
              Get.to(const PaymentMethods());
            }else
            {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          textColor: Appcolors.whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            CustomTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            CustomTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            CustomTextField(
                hint: "Country",
                isPass: false,
                title: "Country",
                controller: controller.countryController),
            CustomTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController),
            CustomTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
