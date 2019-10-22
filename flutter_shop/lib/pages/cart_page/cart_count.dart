import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';

class CartCount extends StatelessWidget {
  final CartInfoModel cartInfoModel;

  CartCount(this.cartInfoModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_reduceBtn(context), _countArea(), _addBtn(context)],
      ),
    );
  }

//  减少
  Widget _reduceBtn(context) {
    return InkWell(
        onTap: () {
          if (this.cartInfoModel.count <= 1) {
            Fluttertoast.showToast(msg: '不能减少了！！');
            return;
          }
          Provider.of<CartNotifier>(context, listen: false)
              .addOrReduceAction(this.cartInfoModel, '-');
        },
        child: Container(
          width: ScreenUtil().setWidth(45),
          height: ScreenUtil().setHeight(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(right: BorderSide(color: Colors.black12, width: 1))),
          child: Text('-'),
        ));
  }

  //  增加
  Widget _addBtn(context) {
    return InkWell(
        onTap: () {
          Provider.of<CartNotifier>(context, listen: false)
              .addOrReduceAction(this.cartInfoModel, '+');
        },
        child: Container(
          width: ScreenUtil().setWidth(45),
          height: ScreenUtil().setHeight(45),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(left: BorderSide(color: Colors.black12, width: 1))),
          child: Text('+'),
        ));
  }

//  中间数量区域
  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${this.cartInfoModel.count}'),
    );
  }
}
