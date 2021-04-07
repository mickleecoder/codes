import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/provider/home_page_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageProvider>(
      create: (context) {
        var provider = new HomePageProvider();
        provider.loadHomePageData();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("首页"),
        ),
        body: Container(
          color: Color(0xFFf4f4f4),
          child: Consumer<HomePageProvider>(
            builder: (_, provider, __) {
              // 加载动画
              if (provider.isloading) {
                return Center(child: CupertinoActivityIndicator());
              }

              //捕获异常
              if (provider.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(provider.errorMsg),
                      OutlineButton(
                          child: Text("刷新"),
                          onPressed: () {
                            provider.loadHomePageData();
                          }),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
