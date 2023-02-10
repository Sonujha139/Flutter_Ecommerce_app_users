import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/consts/consts.dart';
import 'package:ekart/services/firestore_services.dart';
import 'package:ekart/view/main_screen/order_screen/order_detail.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: "My Orders"
            .text
            .color(Color.fromARGB(255, 117, 122, 124))
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.redColor)),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No orders yet!".text.color(Appcolors.darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      Get.to(OrderDetails(
                        data: data[index],
                      ));
                    },
                    leading: "${index + 1}"
                        .text
                        .fontFamily(bold)
                        .color(Appcolors.fontGrey)
                        .xl
                        .make(),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .color(Appcolors.redColor)
                        .fontFamily(semibold)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .fontFamily(bold)
                        .make(),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Appcolors.darkFontGrey,
                        )),
                  );
                });
          }
        },
      ),
    );
  }
}
