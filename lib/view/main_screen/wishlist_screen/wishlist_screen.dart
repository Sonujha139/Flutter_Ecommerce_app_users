import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../consts/consts.dart';
import '../../../services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: "My Wishlist"
            .text
            .color(Appcolors.darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Appcolors.redColor)),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No orders yet!".text.color(Appcolors.darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      leading: Image.network(
                        '${data[index]['p_img'][0]}',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      title: '${data[index]['p_name']}'
                          .text
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                      subtitle: '${data[index]['p_price']}'
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(Appcolors.redColor)
                          .make(),
                      trailing: const Icon(
                        Icons.favorite,
                        color: Appcolors.redColor,
                      ).onTap(() async {
                        await firestore
                            .collection(productsCollection)
                            .doc(data[index].id).set({
                             'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                      }),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
