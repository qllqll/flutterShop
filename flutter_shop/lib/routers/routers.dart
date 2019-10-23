import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routers {
  static String root = '/';
  static String detailsPage='/detail';
  static String mapPage='/map';

  static void configureRouters(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params){
        print('ERROR WAS NOT FOUND');
          return;
      }
    );

    router.define(detailsPage, handler: detailsHandler);
    router.define(mapPage, handler: mapHandler);

  }
}