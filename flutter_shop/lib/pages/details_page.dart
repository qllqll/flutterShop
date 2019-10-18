import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/details_page/details_explain.dart';
import 'package:provider/provider.dart';
import '../provider/details_info.dart';
import 'details_page/details_top.dart';
import 'details_page/details_tabbar.dart';
import 'details_page/details_web.dart';
import 'details_page/details_bottom.dart';
class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage({this.goodsId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                  child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          DetailsTopArea(),
                          DetailsExplain(),
                          DetailsTabBar(),
                          DetailsWeb()
                        ],
                      )),
                ),
                Align(
                  alignment: Alignment(-1,1),
                  child:DetailsBottom(),
                 )
              ],
            );
          } else {
            return Center(child: Text('加载中...'));
          }
        },
        future: _getBackInfo(context),
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    print('---');
    await Provider.of<DetailInfoProvider>(context, listen: false)
        .getGoodsInfo(goodsId);
    return '';
  }
}
