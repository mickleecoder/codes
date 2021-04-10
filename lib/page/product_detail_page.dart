import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/model/product_detail_model.dart';
import 'package:testapp/provider/product_detail_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ProdutDetailPage extends StatefulWidget {
  final String id;
  ProdutDetailPage({Key key, this.id}) : super(key: key);

  @override
  _ProdutDetailPageState createState() => _ProdutDetailPageState();
}

class _ProdutDetailPageState extends State<ProdutDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("京东"),
      ),
      body: Container(
        child: Consumer<ProductDetailProvider>(
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
                          provider.loadProductDetail(id: widget.id);
                        }),
                  ],
                ),
              );
            }

            ProductIDetailModel model = provider.model;
            return Stack(
              children: <Widget>[
                //主题内容
                ListView(
                  children: [
                    //轮播图
                    buildSwiperContainer(model),
                    //标题
                    buildTitleContainer(model),

                    //价格
                    buildPriceContainer(model),

                    //白条支付
                    buildPayContainer(model),

                    //商品件数
                    buildCountContainer(model)
                  ],
                ),

                //底部菜单栏
                buildBottomPositioned(),
              ],
            );
          },
        ),
      ),
    );
  }

  Positioned buildBottomPositioned() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 10,
                color: Color(0xFFE8E8ED),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Container(
                    height: 60,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        Text(
                          "购物车",
                          style: TextStyle(fontSize: 13.0),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    //购物车
                  },
                ),
              ),
              Expanded(
                  child: InkWell(
                child: Container(
                  height: 60,
                  color: Color(0xFFe93b3d),
                  alignment: Alignment.center,
                  child: Text(
                    "加入购物车",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  //加入购物车
                },
              ))
            ],
          ),
        ));
  }

  Container buildCountContainer(ProductIDetailModel model) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
          bottom: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
        ),
      ),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text(
              "已选",
              style: TextStyle(color: Color(0xFF9999999)),
            ),
            Expanded(
                child: Padding(
              child: Text("${model.partData.count}件"),
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
            )),
            Icon(Icons.more_horiz)
          ],
        ),
        onTap: () {
          //选择商品个数
        },
      ),
    );
  }

  Container buildPayContainer(ProductIDetailModel model) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
          bottom: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
        ),
      ),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text(
              "支付",
              style: TextStyle(color: Color(0xFF9999999)),
            ),
            Expanded(
                child: Padding(
              child: Text("【白条支付】首单享受立减优惠"),
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
            )),
            Icon(Icons.more_horiz)
          ],
        ),
        onTap: () {
          //选择支付方式
          // print("baitiao");
          showBaitiao(model);
        },
      ),
    );
  }

  Future showBaitiao(ProductIDetailModel model) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext contex) {
          return Stack(
            children: [
              //顶部标题栏
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    color: Color(0xFFF3F2F8),
                    child: Center(
                      child: Text(
                        "打白条购买",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    width: 40,
                    height: 40,
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          //关闭
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
              //z主题列表
              Container(
                margin: EdgeInsets.only(top: 40.0, bottom: 50.0),
                child: ListView.builder(
                    itemCount: model.baitiao.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Image.asset(
                                "assets/image/unselect.png",
                                width: 20.0,
                                height: 20.0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${model.baitiao[index].desc}"),
                                  Text("${model.baitiao[index].tip}"),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )

              //底部按钮
            ],
          );
        });
  }

  Container buildPriceContainer(ProductIDetailModel model) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Text(
        "¥${model.partData.price}",
        style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFe93b3d)),
      ),
    );
  }

  Container buildTitleContainer(ProductIDetailModel model) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Text(
        model.partData.title,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buildSwiperContainer(ProductIDetailModel model) {
    return Container(
      color: Colors.white,
      height: 400,
      child: Swiper(
        itemCount: model.partData.loopImgUrl.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext contex, int index) {
          return Image.asset("assets${model.partData.loopImgUrl[index]}",
              width: double.infinity, height: 400, fit: BoxFit.fill);
        },
      ),
    );
  }
}
