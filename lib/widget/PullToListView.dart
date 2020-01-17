import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/support/GlobalConstant.dart';

import 'PullToListViewState.dart';

class PullToListView<T> extends StatefulWidget {
  var getData;
  var _buildRow;

  PullToListView({
    Key key,
    void getData(int x),
    Widget _buildRow(T pair),
    String normalImageName,
    String selectedImageName,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new PullToListViewState(getData, _buildRow);
  }
}
