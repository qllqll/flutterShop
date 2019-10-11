import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/child_category.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';
import './provider/child_category.dart';

void main() => runApp(ChangeNotifierProvider<ChildCategoryNotifier>.value(
      value: ChildCategoryNotifier(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
