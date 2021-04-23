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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          )
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
                    trailing: Text(farmaciaList[index]["cidade"]),
                  ),
                );
              })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
