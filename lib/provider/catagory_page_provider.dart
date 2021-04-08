import 'package:flutter/material.dart';
import 'package:testapp/config/net_aip.dart';
import 'package:testapp/net/net_request.dart';

class CategoryPageProvider with ChangeNotifier {
  bool isloading = false;
  bool isError = false;
  String errorMsg = "";
  List<String> categoryNavList = [];
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
