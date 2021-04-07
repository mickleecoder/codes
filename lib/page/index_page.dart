import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/page/home_page.dart';
import 'package:testapp/page/catagory_page.dart';
import 'package:testapp/page/car_page.dart';
import 'package:testapp/page/user_page.dart';
import 'package:testapp/provider/bottom_navi_provider.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<BottomNaviProvider>(
        builder: (_, mProvider, __) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: mProvider.bottomNaviIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '首页',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: '分类',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: '购物车',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: '我的',
              ),
            ],
            onTap: (index) {
              mProvider.changeBoottomNaviIndex(index);
            },
          );
        },
      ),
      body: Consumer<BottomNaviProvider>(
        builder: (_, mProvider, __) => IndexedStack(
          index: mProvider.bottomNaviIndex,
          //层布局控件  只显示一个
          children: <Widget>[
            HomePage(),
            CatagaryPage(),
            CarPage(),
            UserPage(),
          ],
        ),
      ),
    );
  }
}
