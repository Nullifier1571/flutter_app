import 'package:flutter_app/foodlist/FoodItem.dart';

class FoodListResult {
  List<FoodItem> foodList = [];

  FoodListResult.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['foodList'];
    list.forEach((value) => foodList.add(FoodItem.fromJson(value)));
  }
}
