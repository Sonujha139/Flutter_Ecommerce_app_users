
import 'package:ekart/consts/consts.dart';

Widget orderPlacedetail({title1, title2, detail1, detail2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$detail1"
                .text
                .color(Appcolors.redColor)
                .fontFamily(semibold)
                .make(),
          ],
        ),
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$detail2"
                  .text
                   .color(Appcolors.fontGrey)
                  .fontFamily(semibold)
                  .make(),
            ],
          ),
        ),
      ],
    ),
  );
}
