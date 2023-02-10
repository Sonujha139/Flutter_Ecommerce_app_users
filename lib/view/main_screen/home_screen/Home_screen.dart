import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/consts/consts.dart';
import 'package:ekart/controller/Home_controller.dart';
import 'package:ekart/controller/product_controller.dart';
import 'package:ekart/services/firestore_services.dart';
import 'package:ekart/view/main_screen/categories/item_details.dart';
import 'package:ekart/view/main_screen/home_screen/search_screen.dart';
import 'package:ekart/widget/Home_Category_Button.dart';
import 'package:ekart/widget/components/feature_button.dart';
import 'package:get/get.dart';

import '../../../consts/list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controllers = Get.put(ProductController());
    var controller = Get.find<HomeController>();
    return Container(
        padding: const EdgeInsets.all(12),
        color: Appcolors.lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: Appcolors.lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      if (controller.searchController.text.isNotEmptyAndNotNull) {
                        Get.to(SearchScreen(title: controller.searchController.text,));
                      }
                      
                    }),
                    filled: true,
                    fillColor: Appcolors.whiteColor,
                    hintText: searchanything,
                    hintStyle: TextStyle(color: Appcolors.textfieldGrey)),
              ),
            ),
            10.heightBox,
            //swiper brands(consoleslider)
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            sliderList[index],
                            fit: BoxFit.cover,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    20.heightBox,
                    // deals button
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                            (index) => CategoryButton(
                                width: context.screenWidth / 2.5,
                                height: context.screenHeight * 0.15,
                                icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                title: index == 0 ? todayDeal : flashsale))),
                    20.heightBox,
                    //2nd swiper brands(consoleslider)
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            secondSliderList[index],
                            fit: BoxFit.cover,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    20.heightBox,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => CategoryButton(
                                width: context.screenWidth / 3.5,
                                height: context.screenHeight * 0.15,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategories
                                    : index == 1
                                        ? brand
                                        : topSellers))),
                    20.heightBox,

                    //featured categries
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featureCategories.text
                            .color(Appcolors.darkFontGrey)
                            .size(22)
                            .fontFamily(semibold)
                            .make()),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featureButton(
                                        icon: featuredImage1[index],
                                        title: featuredtitle1[index]),
                                    10.heightBox,
                                    featureButton(
                                        icon: featuredImage2[index],
                                        title: featuredtitle2[index]),
                                  ],
                                )).toList(),
                      ),
                    ),

                    20.heightBox,
                    Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Appcolors.redColor,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            featuredProduct.text
                                .fontFamily(bold)
                                .white
                                .size(18)
                                .make(),
                            10.heightBox,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: StreamBuilder(
                                stream: FirestoreServices.getFeaturedProduct(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Appcolors.redColor),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No featured products"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                        children: List.generate(
                                            featuredData.length,
                                            (index) => Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.network(
                                                      featuredData[index]
                                                          ['p_img'][0],
                                                      width: 130,
                                                      height: 130,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    10.heightBox,
                                                    "${featuredData[index]['p_name']}"
                                                        .text
                                                        .fontFamily(semibold)
                                                        .color(Appcolors
                                                            .darkFontGrey)
                                                        .make(),
                                                    10.heightBox,
                                                    "${featuredData[index]['p_price']}"
                                                        .numCurrency
                                                        .text
                                                        .color(
                                                            Appcolors.redColor)
                                                        .fontFamily(bold)
                                                        .size(16)
                                                        .make()
                                                  ],
                                                )
                                                    .box
                                                    .white
                                                    .margin(const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4))
                                                    .roundedSM
                                                    .padding(EdgeInsets.all(8))
                                                    .make()
                                                    .onTap(() {
                                                  Get.to(() => ItemDetails(
                                                        title:
                                                            "${featuredData[index]['p_name']}",
                                                        data:
                                                            featuredData[index],
                                                      ));
                                                })));
                                  }
                                },
                              ),
                            )
                          ]),
                    ),
                    // THIRD SWIPER(consoleslider)
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            secondSliderList[index],
                            fit: BoxFit.cover,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    //all products section
                    20.heightBox,
                    "All Products"
                        .text
                        .fontFamily(bold)
                        .size(20)
                        .make()
                        .centered(),
                    10.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.allproducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(Appcolors.redColor),
                          ));
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allproductsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allproductsdata[index]['p_img'][0],
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    10.heightBox,
                                    "${allproductsdata[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(Appcolors.darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${allproductsdata[index]['p_price']}"
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
                                    .padding(EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                        title:
                                            "${allproductsdata[index]['p_name']}",
                                        data: allproductsdata[index],
                                      ));
                                });
                              });
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        )));
  }
}
