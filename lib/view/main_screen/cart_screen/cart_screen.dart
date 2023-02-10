import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/consts/consts.dart';
import 'package:ekart/controller/cartController.dart';
import 'package:ekart/services/firestore_services.dart';
import 'package:ekart/view/main_screen/cart_screen/shipping_screen.dart';
import 'package:ekart/widget/button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            color: Appcolors.redColor,
            onpress: () {
              Get.to(const ShippingDetails());
            },
            textColor: Appcolors.whiteColor,
            title: "Procced to shipping"),
      ),
      backgroundColor: Appcolors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: "Shopping cart"
            .text
            .color(Appcolors.darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.redColor)),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart is empty".text.color(Appcolors.darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext contect, int index) {
                            return ListTile(
                              leading: Image.network('${data[index]['img']}',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              ),
                              title:
                                  '${data[index]['title']} (x ${data[index]['qty']})'
                                      .text
                                      .fontFamily(semibold)
                                      .size(16)
                                      .make(),
                              subtitle: '${data[index]['tprice']}'
                                  .numCurrency
                                  .text
                                  .fontFamily(semibold)
                                  .color(Appcolors.redColor)
                                  .make(),
                              trailing: const Icon(
                                Icons.delete,
                                color: Appcolors.redColor,
                              ).onTap(() {
                                FirestoreServices.deleteDocument(
                                    data[index].id);
                              }),
                            );
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Total price'
                          .text
                          .fontFamily(semibold)
                          .color(Appcolors.darkFontGrey)
                          .make(),
                      Obx(
                        () => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(Appcolors.redColor)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(12))
                      .color(Appcolors.lightgolden)
                      .roundedSM
                      .make(),
                  10.heightBox,
                  // SizedBox(
                  //   width: context.screenWidth - 60,
                  //   child: ourButton(
                  //       color: Appcolors.redColor,
                  //       onpress: () {},
                  //       textColor: Appcolors.whiteColor,
                  //       title: "Procced to shipping"),
                  // )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
