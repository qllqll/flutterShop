import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';
import '../../provider/details_info.dart';
import '../../provider/currentIndex.dart';

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
                onTap: () {
                  Provider.of<CurrentIndexNotifier>(context, listen: false)
                      .changeIndex(2);
                  Navigator.pop(context);
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(110),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.shopping_cart,
                        size: 35,
                        color: Colors.pink,
                      ),
                    ),
                    Consumer<CartNotifier>(
                      builder: (context, cartNotifier, child) {
                        int allGoodsCount = cartNotifier.allGoodsCount;
                        return Positioned(
                            top: 0,
                            right: ScreenUtil().setWidth(10),
                            child: Container(
//                                padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                            alignment: Alignment.center,
                                width: ScreenUtil().setWidth(50),
                                height: ScreenUtil().setWidth(50),
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  border: Border.all(width: 2,color: Colors.white),
                                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(25))
                                ),
                                child: Text('$allGoodsCount',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(24)
                                ),)));
                      },
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  await Provider.of<CartNotifier>(context, listen: false)
                      .save(goodsId, goodsName, count, price, images);
                  await Provider.of<CartNotifier>(context, listen: false)
                      .getCartInfo();
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
