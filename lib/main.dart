import 'package:flutter/material.dart';
import 'package:testapp/page/index_page.dart';
import 'package:provider/provider.dart';
import 'package:testapp/provider/bottom_navi_provider.dart';

void main() {
  runApp(ChangeNotifierProvider.value(
    value: BottomNaviProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndexPage(),
    );
  }
}
