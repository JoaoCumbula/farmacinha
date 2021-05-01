import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference farmaciaList =
      FirebaseFirestore.instance.collection('farmacia');
  final CollectionReference categoriaList =
      FirebaseFirestore.instance.collection('categoria');

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

  Future getProdutoList(nome) async {
    final CollectionReference produtoList = FirebaseFirestore.instance
        .collection('categoria')
        .doc(nome)
        .collection('produto');
    List itemList = [];
    try {
      await produtoList.get().then((querySnapshot) {
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
