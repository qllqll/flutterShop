import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';
import '../../provider/details_info.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(builder: (context, detailInfo, child) {
      var goodsInfo = detailInfo.goodsInfo;
      if (goodsInfo != null) {
        var goodInfo = goodsInfo.data.goodInfo;
        var goodsId = goodInfo.goodsId;
        var goodsName = goodInfo.goodsName;
        var count = 1;
        var price = goodInfo.presentPrice;
        var images = goodInfo.image1;

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
    });
  }
}
