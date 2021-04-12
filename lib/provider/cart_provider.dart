import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/model/product_detail_model.dart';

class CartProvider with ChangeNotifier {
  List<PartData> models = [];
  Future<void> addToCart(PartData data) async {
    // print(data.toJson());
    SharedPreferences pefs = await SharedPreferences.getInstance();
    //存入缓存
    List<String> list = [];
    // list.add(json.encode(data.toJson()));
    // pefs.setStringList("cartInfo", list);

    // 取出缓存
    // list = pefs.getStringList("cartInfo");
    // print(list);

    //先把缓存里面的东西取出来
    list = pefs.getStringList("cartInfo");
    if (list == null) {
      //将传递过来的数据存到缓存和数组中
      list.add(json.encode(data.toJson()));
      //存到缓存
      pefs.setStringList("cartInfo", list);
      //更新本地数据
      models.add(data);
      //通知听众
      notifyListeners();
    } else {
      // 定义临时数组
      List<String> tempList = [];

      // 判断缓存中是否有对象的商品
      bool isUpdated = false;
      for (var i = 0; i < list.length; i++) {
        PartData temData = PartData.fromJson(json.decode(list[i]));

        //判断商品id
        if (temData.id == data.id) {
          temData.count = data.count;
          isUpdated = true;
        }

        //放到数组中
        String tempDataStr = json.encode(temData.toJson());
        tempList.add(tempDataStr);
        models.add(temData);
      }

      //如果缓存里面的数组，没有现在添加的商品，那么直接田间
      if (isUpdated == false) {
        String str = json.encode(data.toJson());
        tempList.add(str);
        models.add(data);
      }

      //存入缓存
      pefs.setStringList("cartInfo", tempList);

      notifyListeners();
    }
  }
}
