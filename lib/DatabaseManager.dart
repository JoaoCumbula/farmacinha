import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference farmaciaList =
      FirebaseFirestore.instance.collection('farmacia');
  final CollectionReference categoriaList =
      FirebaseFirestore.instance.collection('categoria');
  final CollectionReference produtoList =
      FirebaseFirestore.instance.collection('medicamento');

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

  Future getCategoriaList() async {
    List itemList = [];
    try {
      await categoriaList.get().then((querySnapshot) {
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

  Future getProdutoList() async {
    List itemList = [];
    try {
      await categoriaList.get().then((querySnapshot) {
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
