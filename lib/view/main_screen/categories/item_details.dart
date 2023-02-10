import 'package:ekart/consts/consts.dart';
import 'package:ekart/controller/product_controller.dart';
import 'package:ekart/view/chat_Screen/chat_screen.dart';
import 'package:ekart/widget/button.dart';
import 'package:get/get.dart';

import '../../../consts/list.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValue();
        return true;
      },
      child: Scaffold(
        backgroundColor: Appcolors.lightGrey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              controller.resetValue();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title:
              title!.text.color(Appcolors.darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                      controller.isFav(false);
                    } else {
                      controller.addToWishlist(data.id, context);
                      controller.isFav(true);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: controller.isFav.value
                        ? Appcolors.redColor
                        : Appcolors.darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // swiper section (consoleslider)
                      VxSwiper.builder(
                          height: 300,
                          itemCount: data['p_img'].length,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_img"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      // title and detail section
                      title!.text
                          .size(16)
                          .fontFamily(semibold)
                          .color(Appcolors.darkFontGrey)
                          .make(),
                      10.heightBox,
                      //rating section
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        normalColor: Appcolors.textfieldGrey,
                        selectionColor: Appcolors.golden,
                        count: 5,
                        size: 25,
                        maxRating: 5,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(Appcolors.redColor)
                          .size(18)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.fontFamily(semibold).white.make(),
                              5.heightBox,
                              "${data['p_seller']}"
                                  .text
                                  .fontFamily(semibold)
                                  .size(16)
                                  .color(Appcolors.darkFontGrey)
                                  .make(),
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: Appcolors.darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(const ChatScreen(), arguments: [
                              data['p_seller'],
                              data['vendor_id']
                            ]);
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(EdgeInsets.symmetric(horizontal: 16))
                          .color(Appcolors.textfieldGrey)
                          .make(),

                      //color section
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color:"
                                      .text
                                      .color(Appcolors.textfieldGrey)
                                      .make(),
                                ),
                                Row(
                                    children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(data['p_colors'][index])
                                              .withOpacity(1.0))
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .make()
                                          .onTap(() {
                                        controller.changeColorIndex(index);
                                      }),
                                      Visibility(
                                          visible: index ==
                                              controller.colorIndex.value,
                                          child: const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                )),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),
                            // quantity row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity"
                                      .text
                                      .color(Appcolors.textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantity.value.text
                                          .size(16)
                                          .color(Appcolors.darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data['p_quantity']));
                                            controller.calculateTotalPrice(
                                                int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      "( ${data['p_quantity']} available)"
                                          .text
                                          .color(Appcolors.textfieldGrey)
                                          .make()
                                    ],
                                  ),
                                ),
                              ],
                            ).box.padding(EdgeInsets.all(8)).make(),

                            //Total Row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total"
                                      .text
                                      .color(Appcolors.textfieldGrey)
                                      .make(),
                                ),
                                "${controller.totalPrice.value}"
                                    .numCurrency
                                    .text
                                    .color(Appcolors.redColor)
                                    .size(16)
                                    .fontFamily(bold)
                                    .make()
                              ],
                            )
                                .box
                                .padding(EdgeInsets.all(8))
                                .color(Appcolors.golden)
                                .make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),

                      //description section

                      10.heightBox,

                      "Description"
                          .text
                          .color(Appcolors.darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_desc']}"
                          .text
                          .color(Appcolors.darkFontGrey)
                          .make(),
                      10.heightBox,
                      //button section
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemDetailButtonList.length,
                            (index) => ListTile(
                                  title: "${itemDetailButtonList[index]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(Appcolors.darkFontGrey)
                                      .make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                )),
                      ),
                      20.heightBox,
                      //products may like section
                      productsyoumaylike.text
                          .size(16)
                          .fontFamily(bold)
                          .color(Appcolors.darkFontGrey)
                          .make(),
                      10.heightBox,
                      // i copied this widget from home screen featured products
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                6,
                                (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          imgP1,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        10.heightBox,
                                        "Laptop 32GB/64GB"
                                            .text
                                            .fontFamily(semibold)
                                            .color(Appcolors.darkFontGrey)
                                            .make(),
                                        10.heightBox,
                                        "\$600"
                                            .text
                                            .color(Appcolors.redColor)
                                            .fontFamily(bold)
                                            .size(16)
                                            .make()
                                      ],
                                    )
                                        .box
                                        .white
                                        .margin(
                                            EdgeInsets.symmetric(horizontal: 4))
                                        .roundedSM
                                        .padding(EdgeInsets.all(8))
                                        .make())),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  color: Appcolors.redColor,
                  onpress: () {
                    if (controller.quantity.value > 0) {
                      controller.addToCart(
                        color: data['p_colors'][controller.colorIndex.value],
                        context: context,
                        vendorID: data['vendor_id'],
                        img: data['p_img'][0],
                        qty: controller.quantity.value,
                        sellername: data['p_seller'],
                        title: data['p_name'],
                        tprice: controller.totalPrice.value,
                      );
                      VxToast.show(context, msg: "Added to cart");
                    } else {
                      VxToast.show(context, msg: "Minimum 1 product is required");
                    }
                  },
                  textColor: Appcolors.whiteColor,
                  title: "Add to cart"),
            )
          ],
        ),
      ),
    );
  }
}
