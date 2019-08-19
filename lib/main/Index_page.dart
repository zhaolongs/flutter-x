import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/beans/models.dart';
import 'package:flutter_x/common/common.dart';
import 'package:flutter_x/common/user_helper.dart';
import 'package:flutter_x/main/splash_page.dart';
import 'package:flutter_x/main/welcome_page.dart';
import 'package:flutter_x/view/progress_widget.dart';

/**
 * StatefulWidget，通过调用setState({})方法来刷新控件
 *
 * 启动页面
 */
class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IndexPageState();
  }
}

class IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
    initAsync();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage() {
    switch (indexFlag) {
      case 0:
        return ProgressView();
        break;
      case 1:
        return new SplashPage();
        break;
      case 2:
        return new WelcomePage();
        break;
    }
  }

  var indexFlag = 0;

  /**
   * 加载配制
   */
  void initAsync() async {
    await SpUtil.getInstance();
    if (SpUtil.getBool(Constant.key_guide, defValue: true)) {
      //第一次打开软件 显示splash 页面
      var isSave = SpUtil.putBool(Constant.key_guide, false).toString();
      LogUtil.v("第一次打开软件");
      indexFlag = 1;
    } else {
      LogUtil.v("非 第一次打开软件");
      //多次打开页面 显示广告等待页面
      indexFlag = 2;
    }

    UserHelper.getInstance().init(context);


    setState(() {});
  }
}
