import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
TextEditingController typeController = TextEditingController();
String showTest = '欢迎来到美好人间高级会所';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('美好人间'),),
        body: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  labelText: '美女类型',
                  helperText: '请输入你喜欢的类型'
                ),
                autofocus: false,
              ),
              RaisedButton(
                onPressed: _choiceAction,
                child: Text('选择完毕'),
              ),
              Text(
                showTest,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        )
      ),
    );
  }

  void _choiceAction(){
    print('2222');
    if(typeController.text.toString() == ''){
        showDialog(
        context: context,
        builder:(context)=> AlertDialog(title: Text('美女类型不能为空！')));
    }  else {
       getHttp(typeController.text.toString()).then((val){
          setState(() {
            showTest = val['data']['name'].toString();
          });
       });
    }
  }

  Future getHttp(String typeText) async {
    try{
      Response response;
      var data = {'name':typeText};
      response = await Dio().get('https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
      queryParameters: data
      );
      return response.data;
    }catch(e){
      return print(e);
    }
  }
}