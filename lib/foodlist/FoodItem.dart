import 'package:flutter_app/material/MaterialItem.dart';

///食物类
class FoodItem {
  /// food名称
  String name = "FoodItemName";
  String foodIconUrl = "http://foodIconUrl";

  /// food 是否可供应的
  bool isAvailable;

  /// 烹饪 缺少的材料
  List<MaterialItem> cookLackList = [];

  ///成本价
  double costPrice = 0.0;

  ///售卖价格
  double price = 0.0;

  ///配方id
  int cookId = 0;

  FoodItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    foodIconUrl = json['foodIconUrl'];
    isAvailable = json['isAvailable'];
    List<dynamic> list = json['cookLackList'];
    list.forEach((item) => cookLackList.add(MaterialItem.fromJson(item)));
    costPrice = json['costPrice'];
    price = json['price'];
    cookId = json['cookId'];
  }
}
