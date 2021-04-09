import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/provider/product_detail_provider.dart';

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
            return Container();
          },
        ),
      ),
    );
  }
}
