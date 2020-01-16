import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/GlobalContest.dart';
import 'package:flutter_app/foodlist/FoodItem.dart';
import 'package:flutter_app/foodlist/FoodListResult.dart';
import 'package:flutter_app/foodlist/FoodListWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/net/API.dart';
import 'package:flutter_app/net/DioHelper.dart';

class FoodListState extends State<FoodListWidget> {
  final _foodList = <FoodItem>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<FoodItem>();
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("alpha 点餐系统"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildFoodList(),
    );
  }

  Widget _buildFoodList() {
    return new RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        controller: _scrollController,
        itemCount: _foodList.length + 1,
        itemBuilder: (context, i) {
          print('itemBuilder i ' + i.toString());
          if (_foodList.length == 0) {
            return new Text("无数据");
          } else {
            // 在每一列之前，添加一个1像素高的分隔线widget
            if (i.isOdd) return new Divider();
            // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
            // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
            final index = i ~/ 2;
            //return _buildRow(_foodList[index]);

            if (i == _foodList.length) {
              return _buildLoadMore();
            } else {
              return _buildRow(_foodList[index]);
            }
          }
        },
      ),
    );
  }

  Widget _buildRow(FoodItem pair) {
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.name,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  /// 跳转选择页面
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.name,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved food'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  Future _handleRefresh() async {
    print('refresh');
    getData(true);
  }

  Widget _buildLoadMore() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          // 转圈加载中
          child: new CircularProgressIndicator(),
        ),
      ),
      color: Colors.white70,
    );
  }

  @override
  void initState() {
    super.initState();
    getData(true);
    _scrollController.addListener(() {
//      print("滑动pixels："+_scrollController.position.pixels.toString());
//      print("滑动maxScrollExtent："+_scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData(false);
      }
    });
  }

  void getData(bool isClear) {
    Future<String> result = DioHelper.doGet(GlobalContest.foodListUrl);
    result.then((String data) {
      setState(() {
        var map = jsonDecode(data);
        if (isClear) {
          _foodList.clear();
        }
        _foodList.addAll(FoodListResult.fromJson(map["result"]).foodList);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
