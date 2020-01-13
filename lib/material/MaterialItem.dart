///材料
class MaterialItem {
  ///材料名称
  String name = "";

  ///需要多少
  double need = 0.0;

  ///目前剩余
  double last = 0.0;

  /// 剩余减去需要
  double diff = 0.0;

  ///成本价
  double costPrice = 0.0;

  MaterialItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        need = json['need'],
        last = json['last'],
        diff = json['diff'],
        costPrice = json['costPrice'];
}
