import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/model/product_detail_model.dart';

class CartProvider with ChangeNotifier {
  List<PartData> models = [];
  bool isSelectAll = false;

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
    models.clear();

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

  //获取购物车商品的数量
  int getAllCount() {
    int count = 0;
    for (PartData data in this.models) {
      count += data.count;
    }
    return count;
  }

  //获取购物车商品
  void getCartList() async {
    SharedPreferences pefs = await SharedPreferences.getInstance();
    //存入缓存
    List<String> list = [];

    // 取出缓存
    list = pefs.getStringList("cartInfo");
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        PartData tmpData = PartData.fromJson(json.decode(list[i]));
        models.add(tmpData);
      }
      notifyListeners();
    }
  }

  //删除商品
  void removeFromCart(String id) async {
    //从缓存中删除
    SharedPreferences pefs = await SharedPreferences.getInstance();
    //存入缓存
    List<String> list = [];

    // 取出缓存
    list = pefs.getStringList("cartInfo");

    for (int i = 0; i < list.length; i++) {
      PartData tempData = PartData.fromJson(json.decode(list[i]));
      if (tempData.id == id) {
        list.remove(list[i]);
        break;
      }
    }

    for (int i = 0; i < models.length; i++) {
      if (this.models[i].id == id) {
        this.models.remove(models[i]);
        break;
      }
    }
    //存入缓存
    pefs.setStringList("cartInfo", list);

    notifyListeners();
  }

  void chaneSelectID(String id) {
    // print(id);
    for (var i = 0; i < models.length; i++) {
      if (id == this.models[i].id) {
        this.models[i].isSelected = !this.models[i].isSelected;
      }
      notifyListeners();
    }
  }

  void changeSelectAll() {
    isSelectAll = !isSelectAll;
    for (var i = 0; i < models.length; i++) {
      this.models[i].isSelected = isSelectAll;
    }
    notifyListeners();
  }
}
