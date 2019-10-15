import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(builder: (context, detailInfo, child) {
      if (detailInfo.goodsInfo.data != null) {
        var goodsInfo = detailInfo.goodsInfo.data.goodInfo;
        print(goodsInfo);
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _goodsImage(goodsInfo.image1),
              _goodsName(goodsInfo.goodsName),
              _goodsNum(goodsInfo.goodsSerialNumber)
            ],
          ),
        );
      } else {
        return Center(child: Text('没有数据...'));
      }
    });
  }

//  商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

//  商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(32),
        ),
      ),
    );
  }

//  商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
      child: Text(
        '编号：$num',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }
}
