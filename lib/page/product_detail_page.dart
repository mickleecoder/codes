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
                    Container(
                      color: Colors.white,
                      height: 400,
                      child: Swiper(
                        itemCount: model.partData.loopImgUrl.length,
                        pagination: SwiperPagination(),
                        autoplay: true,
                        itemBuilder: (BuildContext contex, int index) {
                          return Image.asset(
                              "assets${model.partData.loopImgUrl[index]}",
                              width: double.infinity,
                              height: 400,
                              fit: BoxFit.fill);
                        },
                      ),
                    ),
                    //标题
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        model.partData.title,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),

                    //价格
                    Container(
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
                    ),

                    //白条支付
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
                          bottom:
                              BorderSide(width: 1, color: Color(0xFFE8E8ED)),
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
                        },
                      ),
                    )

                    //商品件数
                  ],
                ),

                //底部菜单栏
                Positioned(
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
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
