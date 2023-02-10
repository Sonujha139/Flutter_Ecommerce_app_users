

import 'package:ekart/consts/consts.dart';

Widget CategoryButton({width, height, icon ,String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
  Image.asset(icon,width: 26,),
  10.heightBox,
 title!.text.fontFamily(semibold).color(Appcolors.darkFontGrey).make()
  ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
