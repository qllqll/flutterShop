import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('刷新界面');
    return Container(
      child: Scaffold(
        body: Center(
            child: Column(
          children: <Widget>[Number(), MyButton()],
        )),
      ),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('first page rebuild');
    return Container(margin: EdgeInsets.only(top: 30), child: Text('购物车'));
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('second screen rebuild');
    return Container(
      child: RaisedButton(
        onPressed: () {
        },
        child: Text('递增'),
      ),
    );
  }
}
