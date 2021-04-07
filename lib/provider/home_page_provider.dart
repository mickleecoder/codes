import 'package:flutter/material.dart';
import 'package:testapp/config/net_aip.dart';
import 'package:testapp/model/home_page_model.dart';
import 'package:testapp/net/net_request.dart';

class HomePageProvider with ChangeNotifier {
  HomePageModel model;
  bool isloading = false;
  bool isError = false;
  String errorMsg = "";
  loadHomePageData() {
    isloading = true;
    isError = false;
    errorMsg = "";
    NetRequest().requestData(NetApi.HOME_PAGE).then((res) {
      isloading = false;
      if (res.code == 200) {
        print(res.data);
        model = HomePageModel.fromJson(res.data);
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
