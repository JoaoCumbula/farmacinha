import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference farmaciaList =
      FirebaseFirestore.instance.collection('farmacia');

  Future getFarmaciaList() async {
    List itemList = [];
    try {
      await farmaciaList.get().then((querySnapshot) {
        print("loaded snapshot");
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    } catch (e) {
      print(e.toString());
      print("Doesn't exist");
    }
  }
}
