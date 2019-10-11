import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategoryNotifier with ChangeNotifier {
  List<BxMallSubDto> _childCategoryList = [];
  List<BxMallSubDto>  get childCategoryList => _childCategoryList;

  getChildCategory(List<BxMallSubDto> list){
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    _childCategoryList = [all];
    _childCategoryList.addAll(list);
    notifyListeners();
  }
}