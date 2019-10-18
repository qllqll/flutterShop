import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import 'cart_page/cart_item.dart';
import 'cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('刷新界面');
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text('购物车'),
          ),
          body: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Consumer<CartNotifier>(
                      builder: (context, cartNotifier, child) {
                    List<CartInfoModel> cartList = cartNotifier.cartList;
                    return Stack(
                      children: <Widget>[
                        ListView.builder(
                            itemBuilder: (context, index) {
                              return CartItem(cartList[index]);
                            },
                            itemCount: cartList.length),
                        Positioned(
                          child: CartBottom(),
                          bottom: 0,
                          left: 0,
                        )
                      ],
                    );
                  });
                } else {
                  return Center(
                    child: Text('正在加载'),
                  );
                }
              },
              future: _getCartInfo(context))),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartNotifier>(context, listen: false).getCartInfo();
    return '';
  }
}
