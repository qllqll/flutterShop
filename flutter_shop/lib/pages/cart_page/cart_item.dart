import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/cart_page/cart_count.dart';
import '../../model/cart_info.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          _cartCheckBtn(context,item),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context)
        ],
      ),
    );
  }

//  多选按钮
  Widget _cartCheckBtn(context, item) {
    return Container(
      child: Checkbox(
          value: item.isCheck, activeColor: Colors.pink, onChanged: (bool val) {}),
    );
  }

//商品图片
  Widget _cartImage() {
    return Container(
      width: ScreenUtil().setHeight(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black12)
      ),
      child: Image.network(item.images),
    );
  }

//  商品名称
  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(300),
              child: Text(item.goodsName,
              textAlign: TextAlign.left)
          ),

          CartCount()
        ],
      ),
    );
  }

//  商品价格
  Widget _cartPrice(context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provider.of<CartNotifier>(context,listen: false).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
