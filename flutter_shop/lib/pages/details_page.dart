import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/details_info.dart';
import 'details_page/details_top.dart';

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
            return Container(

              child: SingleChildScrollView(
                child:Column(
                children: <Widget>[
                  DetailsTopArea()
                ],
              )),
            );
          } else {
            return Text('加载中...');
          }
        },
        future: _getBackInfo(context),
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    print('---');
    await Provider.of<DetailInfoProvider>(context,listen: false).getGoodsInfo(goodsId);
    return '';
  }
}
