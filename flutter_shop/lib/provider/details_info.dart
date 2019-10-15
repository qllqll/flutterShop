import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailInfoProvider with ChangeNotifier {
  DetailsModel _goodsInfo = DetailsModel();
  DetailsModel get goodsInfo => _goodsInfo;

//  从后台获取商品
  getGoodsInfo(String id){
    var formData = {'goodId':id};
    request('getGoodDetailById',formData:formData).then((val){
      var responseData = json.decode(val.toString());
      _goodsInfo = DetailsModel.fromJson(responseData);
      print(_goodsInfo);
      notifyListeners();
    });
  }
}

