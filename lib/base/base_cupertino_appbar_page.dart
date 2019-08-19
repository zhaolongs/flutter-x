import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/common/common_colors.dart';

import 'base_page.dart';

abstract class BaseCupertinoPage<T extends StatefulWidget> extends BasePage {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = buildInitState();
    if (appBar == null) {
      title == null ? appBar = null : buildDefaultBar(title);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoApp(
      theme: CommonColors.cupertinoThemeData,
      supportedLocales: [
        //此处
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      home: Scaffold(
//        appBar: appBar,
        //显示的页面
        body: buildWidget(context),
      ),
    );
  }

  Widget buildWidget(BuildContext context);

  String buildInitState();
}
