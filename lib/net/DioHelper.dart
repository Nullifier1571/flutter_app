import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/GlobalContest.dart';
import 'package:flutter_app/foodlist/FoodListResult.dart';
import 'dart:convert';

import 'package:flutter_app/net/API.dart';

class DioHelper {
  static BaseOptions options = new BaseOptions(
    baseUrl: GlobalContest.host,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static Dio create() {
    Dio dio = new Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
        return GlobalContest.isProxyChecked
            ? 'PROXY ' + GlobalContest.proxyHost
            : 'DIRECT';
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        //校验逻辑
        return true;
      };
    };
    return dio;
  }

  static Future<String> doGet(String url) async {
    Response response = await DioHelper.create().get(url);
    String result = response.data.toString();
    print("result----------" + result);
    return result;
  }
}
