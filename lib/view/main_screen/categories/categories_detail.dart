import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/consts/consts.dart';
import 'package:ekart/controller/product_controller.dart';
import 'package:ekart/services/firestore_services.dart';
import 'package:ekart/view/main_screen/categories/item_details.dart';
import 'package:ekart/widget/bg_widget.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatefulWidget {
  final String? title;
  const CategoryDetail({super.key, required this.title});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: widget.title!.text.fontFamily(bold).white.make(),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(Appcolors.darkFontGrey)
                            .makeCentered()
                            .box
                            .rounded
                            .white
                            .size(120, 60)
                            .margin(EdgeInsets.symmetric(horizontal: 4))
                            .make()
                            .onTap(() {
                          switchCategory("${controller.subcat[index]}", );
                          setState(() {  
                          });
                        }))),
          ),
          20.heightBox,
          StreamBuilder(
            stream: productMethod,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Expanded(
                  child:  Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Appcolors.redColor)),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child:
                      "no products found!".text.makeCentered(),
                );
              } else {
                var data = snapshot.data!.docs;
                return
                    // items container
                    Expanded(
                        child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data[index]['p_img'][0],
                                    height: 150,
                                    width: 200,
                                    fit: BoxFit.fill,
                                  ),
                                  const Spacer(),
                                  10.heightBox,
                                  "${data[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(Appcolors.darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}"
                                      .numCurrency
                                      .text
                                      .color(Appcolors.redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make()
                                ],
                              )
                                  .box
                                  .white
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .outerShadowSm
                                  .padding(EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(ItemDetails(
                                    title: "${data[index]['p_name']}",
                                    data: data[index]));
                              });
                            }));
              }
            },
          ),
        ],
      ),
    ));
  }
}
