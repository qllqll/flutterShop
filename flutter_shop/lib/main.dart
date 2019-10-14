import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/category_goods_list.dart';
import 'package:flutter_shop/provider/child_category.dart';
import './pages/index_page.dart';
import 'package:provider/provider.dart';
import './provider/child_category.dart';
import './provider/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ChildCategoryNotifier()),
        ChangeNotifierProvider.value(value: CategoryGoodsListNotifier()),
      ],
      child: Container(
        child: MaterialApp(
          title: '百姓生活+',
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage(),
        ),
      ),
    );
  }
}
