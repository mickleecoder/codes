import 'package:flutter/material.dart';

class CatagaryPage extends StatefulWidget {
  CatagaryPage({Key key}) : super(key: key);

  @override
  _CatagaryPageState createState() => _CatagaryPageState();
}

class _CatagaryPageState extends State<CatagaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类"),
      ),
      body: Container(),
    );
  }
}
