import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailInfoProvider with ChangeNotifier {
  DetailsModel _goodsInfo;
  DetailsModel get goodsInfo => _goodsInfo;

  bool isLeft = true;
  bool isRight = false;

//  tabbar的切换方法
  changeLeftAndRight(String changeState){
    if(changeState == 'left'){
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();

  }

//  从后台获取商品
  getGoodsInfo(String id) async{
    var formData = {'goodId':id};
    await request('getGoodDetailById',formData:formData).then((val){
      var responseData = json.decode(val.toString());
      _goodsInfo = DetailsModel.fromJson(responseData);
      print(_goodsInfo);
      notifyListeners();
    });
  }
}

