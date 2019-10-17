import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details.dart';
import 'package:provider/provider.dart';
import '../../provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(builder: (context, val, child) {
      if (val.goodsInfo.data != null) {
        String goodsDetails = val.goodsInfo.data.goodInfo.goodsDetail;
        List comments = val.goodsInfo.data.goodComments;
//        print('-----------${comments[0].userName}');
        var isLeft = val.isLeft;
        if (isLeft) {
          return Container(margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)), child: Html(data: goodsDetails));
        } else {
          if (comments.isNotEmpty) {
            return _comment(comments);
          } else {
            return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text('暂时没评论'),
              ),
            );
          }
        }
      } else {
        return Center(
          child: Text('没有数据...'),
        );
      }
    });
  }

  Widget _comment(List<GoodComments> goodComments) {
    List<Widget> listWidget = goodComments.map((val) {
      return Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
        padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                child: Text('${val.userName}', style: TextStyle(
                  fontSize: ScreenUtil().setSp(26)
                ),)),
            Container(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10),bottom: ScreenUtil().setHeight(10)),
                alignment: Alignment.topLeft, child: Text('${val.comments}')),
            Container(
                alignment: Alignment.topLeft,
                child: Text('${val.discussTime}',style: TextStyle(
                  fontSize:ScreenUtil().setSp(24),
                  color: Colors.black45
                ),)),
          ],
        ),
      );
    }).toList();
    return Wrap(spacing: 1, children: listWidget);
  }
}
