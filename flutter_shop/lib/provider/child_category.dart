import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategoryNotifier with ChangeNotifier {
  List<BxMallSubDto> _childCategoryList = [];
  int _categoryIndex = 0; //大类索引
  int _childIndex = 0; //子类索引
  String _categoryId = '';
  String _subId = '';
  int _page = 1;
  String _noMoreText = '';
  bool _isFromHome = false;

  List<BxMallSubDto> get childCategoryList => _childCategoryList;

  int get categoryIndex => _categoryIndex;

  int get childIndex => _childIndex;

  String get categoryId => _categoryId;

  String get subId => _subId;

  int get page => _page;

  String get noMoreText => _noMoreText;

  bool get isFromHome => _isFromHome;

  getChildCategory(List<BxMallSubDto> list, String id) {
    _page = 1;
    _noMoreText = '';
    _childIndex = 0;
    _categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.mallSubName = '全部';
    all.comments = 'null';
    _childCategoryList = [all];
    _childCategoryList.addAll(list);
    notifyListeners();
  }

//  改变子类索引
  changeChildIndex(index, id) {
    _page = 1;
    _noMoreText = '';
    _subId = id;
    _childIndex = index;
    notifyListeners();
  }

  increasePage() {
    _page++;
  }

  changeNoMoreText(String text) {
    _noMoreText = text;
    notifyListeners();
  }

//首页 点击类别更改
  changeCategory(index, id) {
    _categoryId = id;
    _categoryIndex = index;
    _subId = '';
    _isFromHome = true;
    notifyListeners();
  }

  changeState() {
    _isFromHome = false;
    notifyListeners();
  }
}
