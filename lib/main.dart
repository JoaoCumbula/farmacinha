import 'package:farmacinha/details.dart';
import 'package:flutter/material.dart';
import 'package:farmacinha/DatabaseManager.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: MyHomePage(title: 'Farmacias'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List farmaciaList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getFarmaciaList();

    if (resultant == null) {
      print("Unable to retrieve data");
    } else {
      setState(() {
        farmaciaList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_pharmacy),
        title: Text(widget.title),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
              onPressed: () {}, child: Icon(Icons.search, color: Colors.white)),
        ],
      ),
      body: Container(
          child: ListView.builder(
              itemCount: farmaciaList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(farmaciaList[index]["nome"]),
                    subtitle: Text(farmaciaList[index]["endereco"]),
                    trailing: IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DetailsPage(
                                farmaciaList[index]["nome"],
                                farmaciaList[index]["telefone1"],
                                farmaciaList[index]["telefone2"]);
                          }),
                        );
                      },
                    ),
                  ),
                );
              })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
