import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailInfoProvider>(builder: (context, val, child) {
      var isLeft = val.isLeft;
      var isRight = val.isRight;
      return Container(
        margin: EdgeInsets.only(top: 15),
        child: Row(
          children: <Widget>[
            _myTabBarLeft(context, isLeft),
            _myTabBaRight(context, isRight)
          ],
        ),
      );
    });
  }

  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provider.of<DetailInfoProvider>(context,listen: false).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isLeft ? Colors.pink : Colors.white))),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _myTabBaRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provider.of<DetailInfoProvider>(context,listen: false).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isRight ? Colors.pink : Colors.white))),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}
