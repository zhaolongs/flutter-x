import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

import 'gesture_page.dart';


class GestureIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GestureIndexPageState();
  }
}

class GestureIndexPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("手势处理", backIcon: Icons.arrow_back_ios);
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
        ),
        //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
        buildWhiteFlatButton("GestureAppPage", () {
          RouteUtil.pushPage(context, GestureAppPage());
        }),

      ],
    );
  }
}
