import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';
import '../pages/map_page.dart';


Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>>params){
    String goodsId = params['id'].first;
    return DetailsPage(goodsId:goodsId);
  },
);

Handler mapHandler = Handler(
  handlerFunc: (BuildContext context,Map<String, List<String>>params){
    return MapPage();
  },
);