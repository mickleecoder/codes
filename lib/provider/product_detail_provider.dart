import 'package:flutter/material.dart';
import 'package:testapp/config/net_aip.dart';
import 'package:testapp/model/product_detail_model.dart';
import 'package:testapp/net/net_request.dart';

class ProductDetailProvider with ChangeNotifier {
  ProductIDetailModel model;
  bool isloading = false;
  bool isError = false;
  String errorMsg = "";

  loadProductDetail({String id}) {
    isloading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(NetApi.PRODUCTIONS_DETAIL).then((res) {
      isloading = false;
      // print(res.data);
      if (res.code == 200 && res.data is List) {
        for (var item in res.data) {
          ProductIDetailModel temModel = ProductIDetailModel.fromJson(item);
          // list.add(temModel);
          if (temModel.partData.id == id) {
            model = temModel;
            print(model.toJson());
          }
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
