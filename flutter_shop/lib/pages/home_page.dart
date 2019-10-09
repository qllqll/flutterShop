import 'dart:io';
import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('百姓生活+')),
        body: FutureBuilder(
            future: request('homePageContent',
                formData: {"lon": "115.02932", "lat": "35.76189"}),
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
                String floor1Title =
                    data['data']['floor1Pic']['PICTURE_ADDRESS'];
                List<Map> floor1 = (data['data']['floor1'] as List).cast();
                String floor2Title =
                    data['data']['floor2Pic']['PICTURE_ADDRESS'];
                List<Map> floor2 = (data['data']['floor2'] as List).cast();
                String floor3Title =
                    data['data']['floor3Pic']['PICTURE_ADDRESS'];
                List<Map> floor3 = (data['data']['floor3'] as List).cast();
                return EasyRefresh(
                  child: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      SwiperDiy(swiperDateList: swiperList),
                      TopNavigator(navigatorList: navigatorList),
                      AdBanner(adPicture: adPicture),
                      LeaderPhone(
                          leaderImage: leaderImage, leaderPhone: leaderPhone),
                      Recommend(recommendList: recommendList),
                      FloorTitle(pictureAddress: floor1Title),
                      FloorContent(floorGoodList: floor1),
                      FloorTitle(pictureAddress: floor2Title),
                      FloorContent(floorGoodList: floor2),
                      FloorTitle(pictureAddress: floor3Title),
                      FloorContent(floorGoodList: floor3),
                      _hotGoos()
                    ],
                  )),
                  onLoad: () async {
                    var formData = {'page': page};
                    await request('homePageBelowConten', formData: formData)
                        .then((val) {
                      var data = json.decode(val.toString());
                      List<Map> newGoodsList = (data['data'] as List).cast();
                      setState(() {
                        hotGoodsList.addAll(newGoodsList);
                        page++;
                      });
                    });
                  },
                  footer: ClassicalFooter(
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      infoColor: Colors.pink,
                      showInfo: true,
                      noMoreText: '已经到底了',
                      loadReadyText: '开始加载...',
                      loadingText: '加载中...'
                  ),
                );
              } else {
                return Center(
                  child: Text('加载中',
                      style: TextStyle(fontSize: ScreenUtil().setSp(28.0))),
                );
              }
            }));
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: ScreenUtil().setHeight(10.0)),
    padding: EdgeInsets.fromLTRB(
        0, ScreenUtil().setHeight(5.0), 0, ScreenUtil().setHeight(15.0)),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
            onTap: () {},
            child: Container(
              width: ScreenUtil().setWidth(372),
              color: Colors.white,
              padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(3)),
              child: Column(
                children: <Widget>[
                  Image.network(val['image'],
                      width: ScreenUtil().setWidth(370)),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        '￥${val['mallPrice']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough),
                      )),
                      Expanded(
                          child: Text(
                        '￥${val['price']}',
                        textAlign: TextAlign.center,
                      ))
                    ],
                  )
                ],
              ),
            ));
      }).toList();

      return Wrap(spacing: 2, children: listWidget);
    } else {
      return Text('');
    }
  }

  Widget _hotGoos() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
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
      throw '$url不能进行访问，异常';
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
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setHeight(10.0), ScreenUtil().setWidth(2.0), 0, 0),
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
        padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(6.0), 0, ScreenUtil().setWidth(6.0), 0),
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
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(10.0)),
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
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(10.0)),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {
  final String pictureAddress;

  FloorTitle({this.pictureAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
      child: Image.network(pictureAddress),
    );
  }
}

// 楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodList;

  FloorContent({this.floorGoodList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(children: <Widget>[
      _goodsItem(floorGoodList[0]),
      Column(
        children: <Widget>[
          _goodsItem(floorGoodList[1]),
          _goodsItem(floorGoodList[2])
        ],
      )
    ]);
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodList[3]),
        _goodsItem(floorGoodList[4])
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(goods['image']),
      ),
    );
  }
}

class HotGoods extends StatefulWidget {
  @override
  HotGoodsState createState() => new HotGoodsState();
}

class HotGoodsState extends State<HotGoods> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('加载中...'),
    );
  }

  @override
  void initState() {
    super.initState();
    request('homePageContent', formData: 1).then((val) {
      print(val);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(HotGoods oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}
