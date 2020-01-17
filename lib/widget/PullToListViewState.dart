import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/support/GlobalConstant.dart';

import 'PullToListView.dart';

class PullToListViewState<T> extends State<PullToListView> {
  var getData;
  var _buildRow;

  PullToListViewState(data, _buildRow) {
    this.getData = data;
    this._buildRow = _buildRow;
  }

  final _dataList = <T>[];
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return _buildPullToListView();
  }

  Widget _buildPullToListView() {
    return new RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        controller: _scrollController,
        itemCount: _dataList.length + 1,
        itemBuilder: (context, i) {
          print('itemBuilder i ' + i.toString());
          if (_dataList.length == 0) {
            return new Text("无数据");
          } else {
            // 在每一列之前，添加一个1像素高的分隔线widget
            if (i.isOdd) return new Divider();
            // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
            // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
            final index = i ~/ 2;
            //return _buildRow(_foodList[index]);

            if (i == _dataList.length) {
              return _buildLoadMore();
            } else {
              return _buildRow(_dataList[index]);
            }
          }
        },
      ),
    );
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
    getData(GlobalConstant.REQUEST_OPERATION_INIT);
    _scrollController.addListener(() {
//      print("滑动pixels："+_scrollController.position.pixels.toString());
//      print("滑动maxScrollExtent："+_scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getData(GlobalConstant.REQUEST_OPERATION_PULLUP);
      }
    });
  }

  Future _handleRefresh() async {
    print('refresh');
    getData(GlobalConstant.REQUEST_OPERATION_PULLDOWN);
  }
}
