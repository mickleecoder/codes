import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  CarPage({Key key}) : super(key: key);

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: Container(),
    );
  }
}
