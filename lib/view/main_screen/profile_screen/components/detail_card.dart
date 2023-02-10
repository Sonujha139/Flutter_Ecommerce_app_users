

import 'package:ekart/consts/consts.dart';

Widget detaisCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).size(16).color(Appcolors.darkFontGrey).make(),
      5.heightBox,
      title!.text.color(Appcolors.darkFontGrey).make(),
    ],
  ).box.white.rounded.width(width).height(80).padding(EdgeInsets.all(4)).make();
}
