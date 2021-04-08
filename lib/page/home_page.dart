import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/model/home_page_model.dart';
import 'package:testapp/provider/home_page_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
                  HomePageModel model = provider.model;
                  return ListView(
                    children: [
                      buildAspectRatio(model),
                      //图标分类
                      buildLogos(model),
                      //掌上秒杀头部
                      buildMSHeaderContainer(),
                      //掌上秒杀商品
                      buildMSBodyContainer(model),
                      //广告1
                      buildAds(model.pageRow.ad1),
                      //广告2
                      buildAds(model.pageRow.ad2),
                    ],
                  );
                },
              ),
            )));
  }

//广告
  Widget buildAds(List<String> ads) {
    List<Widget> list = List<Widget>();
    for (var i = 0; i < ads.length; i++) {
      list.add(
        Expanded(child: Image.asset("assets${ads[i]}")),
      );
    }
    return Row(
      children: list,
    );
  }

//掌上秒杀商品
  Container buildMSBodyContainer(HomePageModel model) {
    return Container(
      height: 120,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: model.quicks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets${model.quicks[index].image}",
                    width: 85,
                    height: 85,
                  ),
                  Text(
                    "${model.quicks[index].price}",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            );
          }),
    );
  }

//掌上秒杀头部
  Container buildMSHeaderContainer() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      height: 50,
      child: Row(
        children: [
          Image.asset(
            "assets/image/bej.png",
            width: 90,
            height: 20,
          ),
          Spacer(),
          Text("更多秒杀"),
          Icon(
            CupertinoIcons.right_chevron,
            size: 14.0,
          )
        ],
      ),
    );
  }

  AspectRatio buildAspectRatio(HomePageModel model) {
    return AspectRatio(
      aspectRatio: 72 / 35,
      child: Swiper(
        itemCount: model.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext contex, int index) {
          return Image.asset("assets${model.swipers[index].image}");
        },
      ),
    );
  }

//图标分类
  Widget buildLogos(HomePageModel model) {
    List<Widget> list = List<Widget>();
    //遍历model中的logos数组
    for (var i = 0; i < model.logos.length; i++) {
      list.add(Container(
        width: 60,
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets${model.logos[i].image}",
              width: 50,
              height: 50,
            ),
            Text("${model.logos[i].title}"),
          ],
        ),
      ));
    }

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      height: 170,
      child: Wrap(
        spacing: 7.0,
        runSpacing: 10.0,
        alignment: WrapAlignment.spaceBetween,
        children: list,
      ),
    );
  }
}
