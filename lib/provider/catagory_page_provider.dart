import 'package:flutter/material.dart';
import 'package:testapp/config/net_aip.dart';
import 'package:testapp/model/category_conteng_model.dart';
import 'package:testapp/net/net_request.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isloading = false;
  bool isError = false;
  String errorMsg = "";
  int tabIndex = 0;
  List<String> categoryNavList = [];
  List<CategortContentModel> categoryContentList = [];

  loadCategoryPageData() {
    isloading = true;
    isError = false;
    errorMsg = "";

    NetRequest().requestData(NetApi.CATEGOTY_NAV).then((res) {
      isloading = false;
      if (res.data is List) {
        for (var i = 0; i < res.data.length; i++) {
          categoryNavList.add(res.data[i]);
        }
        loadCategoryContentData(this.tabIndex);
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

  loadCategoryContentData(int index) {
    this.tabIndex = index;
    isloading = true;
    categoryContentList.clear();

    var data = {"title": categoryNavList[index]};
    NetRequest()
        .requestData(NetApi.CATEGOTY_CONTENT, data: data, method: "post")
        .then((res) {
      isloading = false;
      if (res.data is List) {
        for (var item in res.data) {
          CategortContentModel temModel = CategortContentModel.fromJson(item);
          categoryContentList.add(temModel);
        }
      }
      print(res.data);
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isloading = false;
      isError = true;
      notifyListeners();
    });

    notifyListeners();
  }
}
