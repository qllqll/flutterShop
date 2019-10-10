import 'package:flutter/material.dart';
class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Text('购物车'),
        ),
      ),
    );
  }
}
