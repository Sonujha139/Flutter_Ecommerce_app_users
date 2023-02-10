
import 'package:ekart/widget/button.dart';
import 'package:flutter/services.dart';

import '../consts/consts.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Conform"
            .text
            .fontFamily(bold)
            .color(Appcolors.darkFontGrey)
            .size(18)
            .make(),
        const Divider(),
        10.heightBox,
        "Are You sure you want to exit?"
            .text
            .size(16)
            .color(Appcolors.darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: Appcolors.redColor,
                onpress: () {
                  SystemNavigator.pop();
                },
                textColor: Appcolors.whiteColor,
                title: "Yes"),
            ourButton(
                color: Appcolors.redColor,
                onpress: () {
                  Navigator.pop(context);
                },
                textColor: Appcolors.whiteColor,
                title: "No"),
          ],
        )
      ],
    )
        .box
        .color(Appcolors.lightGrey)
        .padding(EdgeInsets.all(14))
        .roundedSM
        .make(),
  );
}
