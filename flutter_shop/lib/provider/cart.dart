import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_info.dart';

class CartNotifier with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //总数量
  bool isAllCheck = true; //是否全选

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
        'images': images,
        'isCheck': true
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

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('CART_INFO');
    cartList = [];
    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        print('----$allPrice-----$allGoodsCount');
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }

//  删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('CART_INFO');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('CART_INFO', cartString);
    await getCartInfo();
  }

//  单个选择状态
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('CART_INFO');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('CART_INFO', cartString);
    await getCartInfo();
  }

//  点击全选
  changeAllCheckBtnState(bool isCkeck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('CART_INFO');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    tempList.forEach((item) {
      if (isCkeck) {
        item['isCheck'] = true;
      } else {
        item['isCheck'] = false;
      }
    });
    cartString = json.encode(tempList).toString();
    prefs.setString('CART_INFO', cartString);
    await getCartInfo();
  }

//  商品数量加减
  addOrReduceAction(CartInfoModel cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('CART_INFO');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    for (var i = 0; i < tempList.length; i++) {
      var item = tempList[i];
      if (item['goodsId'] == cartItem.goodsId) {
        if (todo == '+') {
          cartItem.count++;
        } else if (cartItem.count > 1) {
          cartItem.count--;
        }
        item['count'] = cartItem.count;
      }
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('CART_INFO', cartString);
    await getCartInfo();
  }
}
