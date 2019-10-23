import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(builder: (context,cartNotifier,child){

      return Container(
        height: ScreenUtil().setHeight(110),
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            _selectAllBtn(context,cartNotifier.isAllCheck),
            _allProceArea(cartNotifier.allPrice),
            _goButton(cartNotifier.allGoodsCount),
          ],
        ),
      );
    });

  }

  Widget _selectAllBtn(context,isAllcheck) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Row(
        children: <Widget>[
          Checkbox(
              value: isAllcheck,
              activeColor: Colors.pink,
              onChanged: (bool val) {
                Provider.of<CartNotifier>(context,listen: false).changeAllCheckBtnState(val);
              }),
          Text('全选')
        ],
      ),
    );
  }

  Widget _allProceArea(price) {
    return Container(
      width: ScreenUtil().setWidth(350),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                ),
              )),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '￥${price.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(32), color: Colors.red),
                ),
              )),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(350),
            alignment: Alignment.centerRight,
            child: Text('满10元免配送费，预购免配送费',
                style: TextStyle(
                    color: Colors.black38, fontSize: ScreenUtil().setSp(22))),
          )
        ],
      ),
    );
  }

  Widget _goButton(count) {
    String countString = count > 99 ? '99+' : count.toString();
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(200),
//      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(20),
          ScreenUtil().setWidth(10),
          ScreenUtil().setWidth(20),
          ScreenUtil().setWidth(10)),
      child: InkWell(
        onTap: () {},
        child: Container(
//          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          child: Text(

            '结算（$countString）',
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }
}
