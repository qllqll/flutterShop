import 'package:dio/dio.dart';
import 'dart:async';
import '../config/servcie_url.dart';

// 公共请求方法
Future request(url, {formData}) async {
  try {
    print('........开始获取数据.......');
    Response response;
    Dio dio = new Dio();
    BaseOptions options = BaseOptions(
      contentType: "application/x-www-form-urlencoded",
    );
    dio.options = options;
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:==============> ${e.message}');
  }
}

