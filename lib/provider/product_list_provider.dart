import 'package:flutter/material.dart';
import 'package:testapp/config/net_aip.dart';
import 'package:testapp/model/product_info_model.dart';
import 'package:testapp/net/net_request.dart';

class ProductListProvider with ChangeNotifier {
  ProductInfoModel model;
  bool isloading = false;
  bool isError = false;
  String errorMsg = "";
  List<ProductInfoModel> list = List();

  loadProductList() {
    isloading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(NetApi.PRODUCTIONS_LIST).then((res) {
      isloading = false;
      // print(res.data);
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          ProductInfoModel temModel = ProductInfoModel.fromJson(item);
          list.add(temModel);
        }
        // model = ProductInfoModel.fromJson(res.data);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isloading = false;
      isError = true;
      notifyListeners();
    });
  }
}
