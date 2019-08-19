import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

import 'package:flutter_x/demo/pageview/demo_pageview_left.dart';
import 'package:flutter_x/demo/pageview/demo_pageview_up.dart';
import 'package:flutter_x/demo/pageview/demo_pageview_up_refresh.dart';

import 'demo_pageview_banner.dart';

class PageViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PageViewPageState();
  }
}

class PageViewPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("dialog", backIcon: Icons.arrow_back_ios);
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
        buildWhiteFlatButton("上下切换的pageview", () {
          upanddown(context);
        }),
        buildWhiteFlatButton("左右切换的 pageview", () {
          lefandright(context);
        }),
        buildWhiteFlatButton("下拉刷新 pageview", () {
          refreshPage(context);
        }),
        buildWhiteFlatButton("轮播图 pageview", () {
         bannerPage(context);
        }),

      ],
    );
  }

  void upanddown(BuildContext context) {
    RouteUtil.pushPage(context, UpPageViewPage());
  }

  void lefandright(BuildContext context) {
    RouteUtil.pushPage(context, LeftPageViewPage());

  }

  void refreshPage(BuildContext context) {
    RouteUtil.pushPage(context, UpRefreshPageViewPage());
  }


  void bannerPage(BuildContext context) {
    RouteUtil.pushPage(context, BannerPageViewPage());
  }}
