import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';
import '../../provider/details_info.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provider.of<DetailInfoProvider>(context).goodsInfo;

    if (goodsInfo != null) {
      var goodsId = goodsInfo.goodsId;
      var goodsName = goodsInfo.goodsName;
      var count = 1;
      var price = goodsInfo.presentPrice;
      var images = goodsInfo.image1;

      return Container(
        width: ScreenUtil().setWidth(750),
        color: Colors.white,
        height: ScreenUtil().setHeight(80),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                width: ScreenUtil().setWidth(110),
                alignment: Alignment.center,
                child: Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: Colors.pink,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await Provider.of<CartNotifier>(context)
                    .save(goodsId, goodsName, count, price, images);
              },
              child: Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(320),
                height: ScreenUtil().setHeight(80),
                color: Colors.lightGreen,
                child: Text(
                  '加入购物车',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                await Provider.of<CartNotifier>(context).remove();
              },
              child: Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(320),
                height: ScreenUtil().setHeight(80),
                color: Colors.redAccent,
                child: Text(
                  '立即购买',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(''),
      );
    }
  }
}
