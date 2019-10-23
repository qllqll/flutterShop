import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(title: Text('会员中心')),
      body: ListView(
        children: <Widget>[_topHeader(), _orderTitle(), _orderType(),_actionList()],
      ),
    ));
  }

  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(top: 20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(250),
            height: ScreenUtil().setWidth(250),
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(125)),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://ss0.bdstatic.com/-0U0bnSm1A5BphGlnYG/tam-ogel/4bfc337a463019ab034f5ba7bba37e96_259_194.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 20),
            child: Text(
              '52_hz哈哈哈',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

//  我的订单标题
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          )),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(750 / 4.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode, size: 30,color:Colors.black26),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(750 / 4.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder, size: 30,color:Colors.black26),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(750 / 4.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_car, size: 30,color:Colors.black26),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(750 / 4.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.content_paste, size: 30,color:Colors.black26,),
                Text('待评价')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myListTile(title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color:  Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }
}
