import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_info.dart';

class CartNotifier with ChangeNotifier {
  String cartString = '[]';

  List<CartInfoModel> cartList = [];


  save(goodId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('CART_INFO');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int isval = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodId) {
        tempList[isval]['count'] = item['count'] + 1;
        cartList[isval].count++;
        isHave = true;
      }
      isval++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('CART_INFO', cartString);
    print(cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    cartList = [];
    print('-------------清空完成');
    notifyListeners();
  }

  getCartInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('CART_INFO');
    cartList = [];
    if(cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item){
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }
}
