import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('third page rebuild');
    return Container(child: Scaffold(body: Center(child: Text('购物车'))));
  }
}
