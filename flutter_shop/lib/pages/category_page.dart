import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provider/child_category.dart';
import '../model/category_good_list.dart';
import '../provider/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../routers/application.dart';
import 'package:fluro/fluro.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商品分类'),
        ),
        body: FutureBuilder(
            if(snapshot.hasData) {
              return Container(
                child: Row(
                  children: <Widget>[
                    LeftCategoryNav(),
                    Column(
                      children: <Widget>[
                        RightCategoryNav(),
                        Expanded(child: CategoryGoodList())
                      ],
                    )
                  ],
                ),
              );
            }else{
              return Center(
                child: Text('加载中...'),
              );
            }
          },
          future:request('getCategory')

        )
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChildCategoryNotifier>(builder: (context, val, child) {
      listIndex = val.categoryIndex;
      return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          },
          itemCount: list.length,
        ),
      );
    });
  }

  Widget _leftInkWell(index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    if (Provider
        .of<ChildCategoryNotifier>(context)
        .isFromHome) {
      _getGoodsList();
    }

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;

        Provider.of<ChildCategoryNotifier>(context, listen: false)
            .getChildCategory(childList, list[index].mallCategoryId);
        Provider.of<ChildCategoryNotifier>(context, listen: false)
            .changeCategory(index, list[index].mallCategoryId);
        Provider.of<ChildCategoryNotifier>(context, listen: false)
            .changeState();
        _getGoodsList(categoryId: list[index].mallCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Container(
            alignment: Alignment.center,
            child: Text(
              list[index].mallCategoryName,
              style: TextStyle(fontSize: ScreenUtil().setSp(26)),
            )),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      print('+++++++++++++++++${list[0].bxMallSubDto[0].mallSubName}');

      Provider.of<ChildCategoryNotifier>(context, listen: true)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);

      _getGoodsList(categoryId: list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var formData = {
      'categoryId': categoryId == null
          ? Provider
          .of<ChildCategoryNotifier>(context)
          .categoryId
          : categoryId,
      'categorySubId': Provider
          .of<ChildCategoryNotifier>(context)
          .subId,
      'page': '1',
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodListModel goodsList = CategoryGoodListModel.fromJson(data);
      Provider.of<CategoryGoodsListNotifier>(context, listen: false)
          .getGoodsList(goodsList.data == null ? [] : goodsList.data);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
            Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Consumer<ChildCategoryNotifier>(
            builder: (context, childCategory, child) {
              var childCategoryList = childCategory.childCategoryList;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return _rightInkWell(index, childCategoryList[index]);
                },
                itemCount: childCategoryList.length,
                scrollDirection: Axis.horizontal,
              );
            }));
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isCilck =
    (index == Provider
        .of<ChildCategoryNotifier>(context)
        .childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        Provider.of<ChildCategoryNotifier>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList();
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Text(
              item.mallSubName,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: isCilck ? Colors.pink : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void _getGoodsList() async {
    var formData = {
      'categoryId': Provider
          .of<ChildCategoryNotifier>(context)
          .categoryId,
      'categorySubId': Provider
          .of<ChildCategoryNotifier>(context)
          .subId,
      'page': '1',
    };
    await request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodListModel goodsList = CategoryGoodListModel.fromJson(data);
      Provider.of<CategoryGoodsListNotifier>(context, listen: false)
          .getGoodsList(goodsList.data == null ? [] : goodsList.data);
    });
  }
}

//商品列表
class CategoryGoodList extends StatefulWidget {
  @override
  _CategoryGoodListState createState() => _CategoryGoodListState();
}

class _CategoryGoodListState extends State<CategoryGoodList> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(570),
        child: Consumer<CategoryGoodsListNotifier>(
            builder: (context, childGoodList, child) {
              if (Provider
                  .of<ChildCategoryNotifier>(context)
                  .page == 1 &&
                  scrollController.hasClients) {
                scrollController.jumpTo(0.0);
              }

              if (childGoodList.goodList.isNotEmpty) {
                return EasyRefresh(
                  child: ListView.builder(
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return _ListWidget(childGoodList.goodList[index]);
                    },
                    itemCount: childGoodList.goodList.length,
                  ),
                  onLoad: () async {
                    Provider.of<ChildCategoryNotifier>(context, listen: false)
                        .increasePage();

                    var formData = {
                      'categoryId':
                      Provider
                          .of<ChildCategoryNotifier>(context)
                          .categoryId,
                      'categorySubId':
                      Provider
                          .of<ChildCategoryNotifier>(context)
                          .subId,
                      'page': Provider
                          .of<ChildCategoryNotifier>(context)
                          .page,
                    };
                    await request('getMallGoods', formData: formData).then((
                        val) {
                      var data = json.decode(val.toString());
                      CategoryGoodListModel goodsList =
                      CategoryGoodListModel.fromJson(data);

                      if (goodsList.data == null) {
                        Fluttertoast.showToast(
                            msg: '已经到底了...',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.pink,
                            textColor: Colors.white,
                            fontSize: ScreenUtil().setSp(32));
                        Provider.of<ChildCategoryNotifier>(
                            context, listen: false)
                            .changeNoMoreText('没有更多数据...');
                      } else {
                        Provider.of<CategoryGoodsListNotifier>(context,
                            listen: false)
                            .getMoredsList(goodsList.data);
                      }
                    });
                  },
                  footer: ClassicalFooter(
                      bgColor: Colors.white,
                      textColor: Colors.pink,
                      infoColor: Colors.pink,
                      showInfo: true,
                      noMoreText:
                      Provider
                          .of<ChildCategoryNotifier>(context)
                          .noMoreText,
                      loadedText: '已经到底了',
                      loadReadyText: '开始加载...',
                      loadingText: '加载中...'),
                );
              } else {
                return Center(child: Text('暂时没有数据'));
              }
            }));
  }

  Widget _goodImage(categoryListData) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(categoryListData.image),
    );
  }

  Widget _goodName(categoryListData) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        categoryListData.goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodPrice(categoryListData) {
    return Container(
      width: ScreenUtil().setWidth(370),
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(30), right: ScreenUtil().setWidth(20)),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Text('价格：￥${categoryListData.presentPrice}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(30)))),
          Expanded(
              flex: 1,
              child: Text('￥${categoryListData.oriPrice}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.black26,
                      decoration: TextDecoration.lineThrough))),
        ],
      ),
    );
  }

  Widget _ListWidget(categoryListData) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, "/map", transition: TransitionType.cupertino);
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
            Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodImage(categoryListData),
            Column(
              children: <Widget>[
                _goodName(categoryListData),
                _goodPrice(categoryListData)
              ],
            )
          ],
        ),
      ),
    );
  }
}
