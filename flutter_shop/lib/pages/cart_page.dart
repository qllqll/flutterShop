import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import 'cart_page/cart_item.dart';
import 'cart_page/cart_bottom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('刷新界面');
    _getCartInfo(context);
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: Text('购物车'),
            ),
            body: Consumer<CartNotifier>(
                builder: (context, cartNotifier, child) {
                  List<CartInfoModel> cartList = cartNotifier.cartList;
                  return Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(110)),
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return CartItem(cartList[index]);
                            },
                            itemCount: cartList.length),
                      ),
                      Positioned(
                        child: CartBottom(),
                        bottom: 0,
                        left: 0,
                      )
                    ],
                  );
                })));
  }

  void _getCartInfo(context) {
    Provider.of<CartNotifier>(context, listen: false).getCartInfo();
  }
}
