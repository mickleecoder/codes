import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testapp/model/product_detail_model.dart';
import 'package:testapp/provider/bottom_navi_provider.dart';
import 'package:testapp/provider/cart_provider.dart';
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
                    buildPayContainer(model, provider),

                    //商品件数
                    buildCountContainer(context, model, provider)
                  ],
                ),
                //底部菜单栏
                buildBottomPositioned(context, model),
              ],
            );
          },
        ),
      ),
    );
  }

  Positioned buildBottomPositioned(
      BuildContext context, ProductIDetailModel model) {
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
                        Stack(
                          children: [
                            Container(
                                width: 40,
                                height: 30,
                                child: Icon(Icons.shopping_cart)),
                            Consumer<CartProvider>(
                                builder: (_, cartProvider, __) {
                              return Positioned(
                                right: 0.0,
                                child: cartProvider.getAllCount() > 0
                                    ? Container(
                                        padding: EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(11.0)),
                                        child: Text(
                                          "${cartProvider.getAllCount()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0),
                                        ),
                                      )
                                    : Container(),
                              );
                            })
                          ],
                        ),
                        Text(
                          "购物车",
                          style: TextStyle(fontSize: 13.0),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    //购物车
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                    //跳转到购物车
                    Provider.of<BottomNaviProvider>(context, listen: false)
                        .changeBoottomNaviIndex(2);
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
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(model.partData);
                    Fluttertoast.showToast(
                        msg: "加入购物车",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Color(0xFFe93b3d),
                        fontSize: 16.0);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Container buildCountContainer(BuildContext contex, ProductIDetailModel model,
      ProductDetailProvider provider) {
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
          return showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return ChangeNotifierProvider.value(
                  value: provider,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                      ),
                      //顶部：包含图片 价格 和数量信息
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Image.asset(
                              "assets${model.partData.loopImgUrl[0]}",
                              width: 90,
                              height: 90,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "${model.partData.price}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE93B3D)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("已选${model.partData.count}")
                            ],
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: IconButton(
                                icon: Icon(Icons.close),
                                iconSize: 20,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          )
                        ],
                      ),
                      //中间：数量 加减号
                      Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(top: 90.0, bottom: 50.0),
                        padding:
                            EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
                        child: Consumer<ProductDetailProvider>(
                            builder: (_, temProvider, __) {
                          return Row(
                            children: [
                              Text("数量"),
                              Spacer(),
                              InkWell(
                                child: Container(
                                  width: 35.0,
                                  height: 35.0,
                                  color: Color(0XFFF7F7F7),
                                  child: Center(
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xFFB0B0B0)),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  //减号
                                  int temCount = model.partData.count;
                                  temCount--;
                                  provider.changeProduvtCount(temCount);
                                },
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Container(
                                width: 35.0,
                                height: 35.0,
                                child: Center(
                                  child: Text("${model.partData.count}"),
                                ),
                              ),
                              SizedBox(
                                width: 2.0,
                              ),
                              InkWell(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  color: Color(0xFFF7F7F7),
                                  child: Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  //加号
                                  int temCount = model.partData.count;
                                  temCount++;
                                  provider.changeProduvtCount(temCount);
                                },
                              )
                            ],
                          );
                        }),
                      ),
                      //底部：加入购物车按钮
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          child: Container(
                            height: 50,
                            color: Color(0xFFE93B3D),
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
                            // 加入购物车
                            Provider.of<CartProvider>(context, listen: false)
                                .addToCart(model.partData);
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Container buildPayContainer(
      ProductIDetailModel model, ProductDetailProvider provider) {
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
          showBaitiao(model, provider);
        },
      ),
    );
  }

  Future showBaitiao(
      ProductIDetailModel model, ProductDetailProvider provider) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext contex) {
          return ChangeNotifierProvider<ProductDetailProvider>.value(
            value: provider,
            child: Stack(
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
                                child: Consumer<ProductDetailProvider>(
                                  builder: (_, tmProvider, __) {
                                    return Image.asset(
                                      model.baitiao[index].select
                                          ? "assets/image/selected.png"
                                          : "assets/image/unselect.png",
                                      width: 20.0,
                                      height: 20.0,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${model.baitiao[index].desc}",
                                      style: TextStyle(),
                                    ),
                                    Text("${model.baitiao[index].tip}"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            //选择分期类型
                            provider.changeBaitiaoSelected(index);
                          },
                        );
                      }),
                ),

                //底部按钮
                //
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    child: Container(
                      width: double.infinity,
                      height: 50.0,
                      color: Color(0xFFE4393C),
                      child: Center(
                        child: Text(
                          "立即打白条",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    onTap: () {
                      //确定分期并且返回
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
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
