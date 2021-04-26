import 'package:farmacinha/productList.dart';
import 'package:flutter/material.dart';
import 'package:farmacinha/DatabaseManager.dart';

class DetailsPage extends StatefulWidget {
  final String nome, endereco;
  DetailsPage(this.nome, this.endereco);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState(this.nome, this.endereco);
  }
}

class _MyHomePageState extends State<DetailsPage> {
  List categoriaList = [];
  String nome, endereco;

  _MyHomePageState(this.nome, this.endereco);

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getCategoriaList();

    if (resultant == null) {
      print("Unable to retrieve data");
    } else {
      setState(() {
        categoriaList = resultant;
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
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: ListTile(
                    title: Text(
                      nome,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      endereco,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  centerTitle: true,
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    moveLastScreen();
                  },
                ),
                automaticallyImplyLeading: false,
                actions: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.search, color: Colors.white))
                ],
              ),
              SliverList(delegate: SliverChildListDelegate(_getCategorias()))
            ],
          ),
        ));
  }

  void moveLastScreen() {
    Navigator.pop(context);
  }

  List<Widget> _getCategorias() {
    List<Card> _cards = [];
    for (int i = 0; i < categoriaList.length; i++) {
      _cards.add(Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
              title: Text(categoriaList[i]["nome"]),
              trailing: IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ProductList(categoriaList[i]["nome"]);
                      }),
                    );
                  }))));
    }
    return _cards;
  }
}
