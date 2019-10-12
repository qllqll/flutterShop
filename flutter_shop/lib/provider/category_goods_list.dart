import 'package:flutter/material.dart';
import '../model/category_good_list.dart';

class CategoryGoodsListNotifier with ChangeNotifier {
  List<CategoryListData> _goodList = [];

  List<CategoryListData> get goodList => _goodList;
//  点击大类时更换商品类表
  getGoodsList(List<CategoryListData> list) {
    _goodList = list;
    notifyListeners();
  }

  getMoredsList(List<CategoryListData> list) {
    _goodList.addAll(list);
    notifyListeners();
  }
}
