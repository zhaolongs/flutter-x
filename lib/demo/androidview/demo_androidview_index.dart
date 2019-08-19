import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

import 'demo_androidview_textview.dart';
import 'demo_androidview_webview.dart';
import 'demo_iosview_textview.dart';

class AndroidViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MenuIndexPageState();
  }
}

class MenuIndexPageState extends BaseAppBarPageState<StatefulWidget> {
  String buttonText;

  @override
  String buildInitState() {
    if (Platform.isIOS) {
      //ios相关代码
      buttonText = "Ios";
    } else {
      if (Platform.isAndroid) {
        //android相关代码
        buttonText = "Android";
      }
    }
    buildBackBar("调用" + buttonText.toString() + "原生View",
        backIcon: Icons.arrow_back_ios);
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
        buildWhiteFlatButton("调用" + buttonText.toString() + "原生的一个 TextView", () {
          if (Platform.isIOS) {
            //ios相关代码
            RouteUtil.pushPage(context, IosTextViewPage());
          } else {
            if (Platform.isAndroid) {
              //android相关代码
              RouteUtil.pushPage(context, AndroidTextViewPage());
            }
          }

        }),
        buildWhiteFlatButton("调用" + buttonText.toString() + "原生的一个 WebView", () {
          if (Platform.isIOS) {
            //ios相关代码
            RouteUtil.pushPage(context, IosTextViewPage());
          } else {
            if (Platform.isAndroid) {
              //android相关代码
              RouteUtil.pushPage(context, AndroidWebViewPage());
            }
          }
        }),
      ],
    );
  }
}
