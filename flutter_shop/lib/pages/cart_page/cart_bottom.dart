import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
             _selectAllBtn(),
          _allProceArea(),
          _goButtom(),
        ],
      ),
    );
  }

  Widget _selectAllBtn() {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Row(
        children: <Widget>[
          Checkbox(
              value: true, activeColor: Colors.pink, onChanged: (bool val) {}),
          Text('全选')
        ],
      ),
    );
  }

  Widget _allProceArea() {
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
                  '￥0.00',
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

  Widget _goButtom() {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(250),
//      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), ScreenUtil().setWidth(10), ScreenUtil().setWidth(40), ScreenUtil().setWidth(10)),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text(
            '结算(99+)',
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3)),
        ),
      ),
    );
  }
}
