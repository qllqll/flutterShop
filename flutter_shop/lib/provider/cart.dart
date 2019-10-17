import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartNotifier with ChangeNotifier {
  String cartString = '[]';

  save(goodId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('CART_INFO');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int isval = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodId) {
        tempList[isval]['count'] = item['count']++;
        isHave = true;
      }
      isval++;
    });

    if (!isHave) {
      tempList.add({
        'goodsId': goodId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      });
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('CART_INFO', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print('-------------清空完成');
    notifyListeners();
  }
}
