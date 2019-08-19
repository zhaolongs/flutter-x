import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

import 'deom_next_tabbar.dart';
import 'deom_title_tabbar.dart';

class BarIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BarIndexPageState();
  }
}

class BarIndexPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("bar", backIcon: Icons.arrow_back_ios);
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
        buildWhiteFlatButton("TabBar中的Tab菜单", () {
          RouteUtil.pushPage(context, TabBarTabPage());
        }),
        buildWhiteFlatButton("TabBar下的Tab菜单", () {
          RouteUtil.pushPage(context, TabBarAndTopTab());

        }),
        buildWhiteFlatButton("SimpleDialog", () {

        }),
      ],
    );
  }
}
