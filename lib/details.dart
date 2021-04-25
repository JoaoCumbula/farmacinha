import 'package:flutter/material.dart';
import 'package:farmacinha/DatabaseManager.dart';

class DetailsPage extends StatefulWidget {
  final String nome;
  DetailsPage(this.nome);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState(this.nome);
  }
}

class _MyHomePageState extends State<DetailsPage> {
  List categoriaList = [];
  String nome;

  _MyHomePageState(this.nome);

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
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                moveLastScreen();
              },
            ),
            title: Text(nome),
            centerTitle: false,
          ),
          body: Center(
              child: ListView.builder(
                  itemCount: categoriaList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(categoriaList[index]["nome"]),
                        trailing: IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DetailsPage(
                                    categoriaList[index]["nome"]);
                              }),
                            );
                          },
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
