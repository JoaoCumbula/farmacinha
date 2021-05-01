import 'package:flutter/material.dart';
import 'package:farmacinha/DatabaseManager.dart';

class ProductList extends StatefulWidget {
  final String nome;
  ProductList(this.nome);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState(this.nome);
  }
}

class _MyHomePageState extends State<ProductList> {
  List productList = [];
  String nome;

  _MyHomePageState(this.nome);

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getProdutoList(nome);

    if (resultant == null) {
      print("Unable to retrieve data");
    } else {
      setState(() {
        productList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
        onWillPop: () {
          moveLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                moveLastScreen();
              },
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
            ],
            title: Text(nome),
            centerTitle: false,
          ),
          body: Center(
              child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(productList[index]["nome"]),
                        subtitle: Text(productList[index]["descricao"]),
                        trailing: Text(
                          productList[index]["preco"] + " MZN",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  })),
        ));
  }

  void moveLastScreen() {
    Navigator.pop(context);
  }
}
