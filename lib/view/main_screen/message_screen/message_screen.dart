import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/consts/consts.dart';
import 'package:ekart/services/firestore_services.dart';
import 'package:ekart/view/chat_Screen/chat_screen.dart';
import 'package:get/get.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: "My Messages"
            .text
            .color(Appcolors.darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.redColor)),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child:
                  "No messages yet!".text.color(Appcolors.darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            return SizedBox(
                              height: 80,
                              child: Card(
                                color: Appcolors.lightGrey,
                                elevation: 5,
                                child: ListTile(
                                  onTap: () {
                                    Get.to(const ChatScreen(), arguments: [
                                      data[index]['friend_name'],
                                      data[index]['toId'],
                                    ]);
                                  },
                                  leading: const CircleAvatar(
                                    backgroundColor: Appcolors.redColor,
                                    child: Icon(
                                      Icons.person,
                                      color: Appcolors.whiteColor,
                                    ),
                                  ),
                                  title: "${data[index]['friend_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(Appcolors.darkFontGrey)
                                      .make(),
                                  subtitle:
                                      "${data[index]['last_msg']}".text.make(),
                                ),
                              ),
                            );
                          }))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
