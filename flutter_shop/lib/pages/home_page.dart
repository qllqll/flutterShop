import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  String homePageContent = '这在获取数据';

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('111');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('百姓生活+')),
        body: FutureBuilder(
            future: getHomePageContent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = json.decode(snapshot.data.toString());
                List<Map> swiperList = (data['data']['slides'] as List).cast();
                List<Map> navigatorList =
                    (data['data']['category'] as List).cast();
                String adPicture =
                    data['data']['advertesPicture']['PICTURE_ADDRESS'];
                String leaderImage = data['data']['shopInfo']['leaderImage'];
                String leaderPhone = data['data']['shopInfo']['leaderPhone'];
                List<Map> recommendList =
                (data['data']['recommend'] as List).cast();
                return SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    SwiperDiy(swiperDateList: swiperList),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(adPicture: adPicture),
                    LeaderPhone(
                        leaderImage: leaderImage, leaderPhone: leaderPhone),
                    Recommend(recommendList:recommendList)
                  ],
                ));
              } else {
                return Center(
                  child: Text('加载中',
                      style: TextStyle(fontSize: ScreenUtil().setSp(28.0))),
                );
              }
            }));
  }
}

// 首页轮播图片
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  SwiperDiy({this.swiperDateList});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(333),
        width: ScreenUtil().setWidth(750),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              swiperDateList[index]['image'],
              fit: BoxFit.fill,
            );
          },
          itemCount: swiperDateList.length,
          pagination: SwiperPagination(),
          autoplay: true,
        ));
  }
}

//分类
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
        onTap: () {
          print('点击了导航');
        },
        child: Column(
          children: <Widget>[
            Image.network(
              item['image'],
              width: ScreenUtil().setWidth(95),
            ),
            Text(item['mallCategoryName'])
          ],
        ));
  }

  TopNavigator({this.navigatorList});

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
      child: GridView.count(
          crossAxisCount: 5,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
          children: navigatorList.map((item) {
            return _gridViewItemUI(context, item);
          }).toList()),
    );
  }
}

//广告
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({this.adPicture});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({this.leaderImage, this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '${url}不能进行访问，异常';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({this.recommendList});

//  标题头部
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      height: ScreenUtil().setHeight(50),
      padding: EdgeInsets.fromLTRB(10.0, 2, 0, 0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

//  商品的每一项
  Widget _goodItem(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

//  横向列表方法
  Widget _recommendList() {
    return Container(
        height: ScreenUtil().setHeight(330),
        padding: EdgeInsets.only(top: 10.0),
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _goodItem(index);
          },
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
        margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList()
        ],
      ),
    );
  }
}
