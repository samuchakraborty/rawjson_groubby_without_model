import 'package:flutter/material.dart';

import 'network.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    // TODO: implement initState
    Network().getCart();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Container(
        child: Text("hello world!"),


      ),
    ));
  }
}
