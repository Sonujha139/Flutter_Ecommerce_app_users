import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/consts/consts.dart';
import 'package:ekart/services/firestore_services.dart';
import 'package:ekart/view/main_screen/categories/item_details.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.whiteColor,
      appBar: AppBar(
        backgroundColor: Appcolors.whiteColor,
        elevation: 1,
        centerTitle: true,
        title: title!.text.color(Appcolors.darkFontGrey).fontFamily(semibold).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.redColor)),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No product found!".text.color(Appcolors.darkFontGrey).make(),
            );
          } else {
              var data = snapshot.data!.docs;
              var filtered =data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                    
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300),
                        children: filtered.mapIndexed((currentValue, index) => Column(
                                    children: [
                                      Image.network(
                                        filtered[index]['p_img'][0],
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const Spacer(),
                                      10.heightBox,
                                      "${filtered[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(Appcolors.darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${filtered[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .color(Appcolors.redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make()
                                    ], 
                      
                        ).box.white
                                    .margin(const EdgeInsets.symmetric(horizontal: 4))
                                    .roundedSM.outerShadowMd
                                    .padding(const EdgeInsets.all(12)).make().onTap(() {
                                 Get.to(() => ItemDetails(
                                        title:
                                            "${filtered[index]['p_name']}",
                                        data: filtered[index],
                                      ));
                                })                           
                        ).toList(),
                        ),
              );
            }
          }),
    );
  }
}
