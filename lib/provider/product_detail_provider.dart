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

  //分期切换
  void changeBaitiaoSelected(int index) {
    if (this.model.baitiao[index].select == false) {
      for (int i = 0; i < this.model.baitiao.length; i++) {
        if (i == index) {
          this.model.baitiao[i].select = true;
        } else {
          this.model.baitiao[i].select = false;
        }
      }
      notifyListeners();
    }
  }

  //数量变化
  void changeProduvtCount(int count) {
    if (count > 0 && this.model.partData.count != count) {
      this.model.partData.count = count;
      notifyListeners();
    }
  }
}
