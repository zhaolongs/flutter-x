import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

import 'demo_bottom_menu.dart';
import 'demo_bottom_menu_bar.dart';
import 'demo_bottom_menu_float.dart';
import 'demo_bottom_menu_tab.dart';

class MenuIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MenuIndexPageState();
  }
}

class MenuIndexPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("菜单栏", backIcon: Icons.arrow_back_ios);
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
        buildWhiteFlatButton("菜单栏TabBar + TabBarView", () {
          RouteUtil.pushPage(context, BotomeMenumTabBarPage());
        }),
        buildWhiteFlatButton("规则底部菜单栏", () {
          RouteUtil.pushPage(context, BotomeMenumPage());
        }),
        buildWhiteFlatButton("不规则底部菜单栏", () {
          RouteUtil.pushPage(context, BotomeMenumBarPage());
        }),
        buildWhiteFlatButton("FloatNavigator", () {
          RouteUtil.pushPage(context, MoveBottomMenu());
        }),

      ],
    );
  }
}
