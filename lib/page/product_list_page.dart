import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/model/product_info_model.dart';
import 'package:testapp/page/product_detail_page.dart';
import 'package:testapp/provider/product_detail_provider.dart';
import 'package:testapp/provider/product_list_provider.dart';

class ProductListPage extends StatelessWidget {
  final String title;
  const ProductListPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(title: Text("${this.title}")),
          body: Container(
            color: Color(0xFFF7F7F7),
            child: Consumer<ProductListProvider>(
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
                              provider.loadProductList();
                            }),
                      ],
                    ),
                  );
                }

                //返回数据展示
                return ListView.builder(
                    itemCount: provider.list.length,
                    itemBuilder: (context, index) {
                      ProductInfoModel model = provider.list[index];
                      // 展示数据
                      return InkWell(
                        child: buildProductItem(model),
                        onTap: () {
                          //前往商品详情页面
                          //前往商品页面
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<ProductDetailProvider>(
                                    create: (context) {
                                      ProductDetailProvider provider =
                                          ProductDetailProvider();
                                      provider.loadProductDetail(id: model.id);
                                      return provider;
                                    },
                                    child: Consumer<ProductDetailProvider>(
                                      builder: (_, provider, __) {
                                        return Container(
                                          child: ProdutDetailPage(id: model.id),
                                        );
                                      },
                                    ),
                                  )));
                        },
                      );
                    });
              },
            ),
          )),
    );
  }

  Row buildProductItem(ProductInfoModel model) {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets${model.cover}",
          width: 95,
          height: 120,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                model.price,
                style: TextStyle(fontSize: 16.0, color: Color(0xFFe93b3d)),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    "${model.comment}条评价",
                    style: TextStyle(fontSize: 16.0, color: Color(0xFF999999)),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "好评率${model.rate}",
                    style: TextStyle(fontSize: 16.0, color: Color(0xFF999999)),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ))
      ],
    );
  }
}
