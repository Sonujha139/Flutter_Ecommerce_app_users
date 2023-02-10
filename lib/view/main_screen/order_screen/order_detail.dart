import 'package:ekart/consts/consts.dart';
import 'package:ekart/view/main_screen/order_screen/components/order_place_detail.dart';
import 'package:ekart/view/main_screen/order_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: "Order Details"
            .text
            .color(Appcolors.darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: Appcolors.redColor,
                  icon: Icons.done,
                  title: "Placed",
                  showDone: data['order_placed']),
              orderStatus(
                  color: Vx.blue900,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: data['order_confirmed']),
              orderStatus(
                  color: Vx.yellow700,
                  icon: Icons.delivery_dining,
                  title: "On Delivery",
                  showDone: data['order_on_delivery']),
              orderStatus(
                  color: Vx.purple800,
                  icon: Icons.done_all_rounded,
                  title: "Delivered",
                  showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlacedetail(
                    title1: "Order Code",
                    detail1: data['order_code'],
                    title2: "Shipping Method",
                    detail2: data['shipping_method'],
                  ),
                  orderPlacedetail(
                    title1: "Order Date",
                    detail1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    title2: "Payment Method",
                    detail2: data['payment_method'],
                  ),
                  orderPlacedetail(
                    title1: "Payment_Method",
                    detail1: "Unpaid",
                    title2: "Delivery Status",
                    detail2: "Order Placed",
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "Name:- " " ${data['order_by_name']}".text.make(),
                            "Email:- " " ${data['order_by_email']}".text.make(),
                            "Address:- " " ${data['order_by_address']}"
                                .text
                                .make(),
                            "City:- " " ${data['order_by_city']}".text.make(),
                            "State:- " " ${data['order_by_state']}".text.make(),
                            "Pin Code:- " " ${data['order_by_postalcode']}"
                                .text
                                .make(),
                            "Country:- " " ${data['order_by_country']}"
                                .text
                                .make(),
                            "Pnone:- " " ${data['order_by_phone']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 110,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .numCurrency
                                  .text
                                  .color(Appcolors.redColor)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(Appcolors.darkFontGrey)
                  .fontFamily(semibold)
                  .make()
                  .centered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  children: List.generate(data['orders'].length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlacedetail(
                      title1: data['orders'][index]['title'],
                      title2: data['orders'][index]['tprice'],
                      detail1: "${data['orders'][index]['qty']} X",
                      detail2: "Refundable"
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: 30,
                        height: 10,
                        color: Color(data['orders'][index]['color']),
                      ),
                    ), 
                    const Divider()
                  ],
                );
              }).toList(),
              ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),
              20.heightBox,
                
            ],
          ),
        ),
      ),
    );
  }
}
