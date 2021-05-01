import 'package:farmacinha/productList.dart';
import 'package:flutter/material.dart';
import 'package:farmacinha/DatabaseManager.dart';

class DetailsPage extends StatefulWidget {
  final String nome, phone1, phone2;
  DetailsPage(this.nome, this.phone1, this.phone2);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState(this.nome, this.phone1, this.phone2);
  }
}

class _MyHomePageState extends State<DetailsPage> {
  List categoriaList = [];
  String nome, phone1, phone2;

  _MyHomePageState(this.nome, this.phone1, this.phone2);

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
        // ignore: missing_return
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
                expandedHeight: 150.0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  title: ListTile(
                    title: Text(
                      "$nome",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "$phone1, $phone2",
                      textAlign: TextAlign.center,
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
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.call), onPressed: () {}),
                  IconButton(icon: Icon(Icons.search), onPressed: () {})
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
