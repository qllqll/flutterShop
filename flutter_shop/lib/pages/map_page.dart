import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:amap_core_fluttify/amap_core_fluttify.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地图'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: AmapView(
        onMapCreated: (controller) async {
          controller.showCompass(true);
          controller.showZoomControl(true);
          controller.showLocateControl(true);
          controller.showScaleControl(true);
          controller.setZoomGesturesEnabled(true);
          controller.setScrollGesturesEnabled(true);
          controller.showMyLocation(true);
        },
      ),
    );
  }
}
