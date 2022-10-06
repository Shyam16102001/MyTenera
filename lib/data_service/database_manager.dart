import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseManager {
  Future getAuctionList() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection("Auction")
          .get()
          .then((querySnapshot) {
        for (var i = 0; i < querySnapshot.docs.length; i++) {
          itemsList.add(querySnapshot.docs[i].data());
          itemsList[i]['ID'] = querySnapshot.docs[i].id;
        }
      });

      return itemsList;
    } catch (e) {
      return null;
    }
  }
}
