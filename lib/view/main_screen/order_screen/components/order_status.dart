import 'package:ekart/consts/consts.dart';

Widget orderStatus({icon,color,title, showDone}) {
  return ListTile(
    leading:Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(const EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(Appcolors.darkFontGrey).make(),
        showDone ? const  Icon(Icons.done,
        color: Appcolors.redColor,): Container()
        ],
      ),
    ),
  );
}
