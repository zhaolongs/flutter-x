import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/http/http_home_manager.dart';
import 'package:flutter_x/res/dimens.dart';
import 'package:flutter_x/view/progress_widget.dart';

abstract class BasePage<T extends StatefulWidget> extends State {
  //底部tab 文字默认显示颜色
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  HttpHomeManager homeManager = new HttpHomeManager();
  //底部tab 文字选中显示颜色
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));

  AppBar appBar;
  Widget buildDefaultBar(String title) {
    return appBar = AppBar(
      backgroundColor: CommonColors.base_red,
      //标题居中显示
      centerTitle: true,
      //返回按钮占位
      leading: Container(),
      //标题显示
      title: Text(title),
    );
  }

  /**
   * title appBar 显示的标题文字
   * backIcon  appBar 显示的返回键图标
   */
  Widget buildBackBar(String title, {backIcon = Icons.arrow_back_ios}) {
    return appBar = AppBar(
      backgroundColor: CommonColors.base_red,
      centerTitle: true,
      //在标题前面显示的一个控件，在首页通常显示应用的 logo；在其他界面通常显示为返回按钮
      leading: IconButton(
          icon: Icon(backIcon),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      //Toolbar 中主要内容，通常显示为当前界面的标题文字
      title: Text(title),
    );
  }

  /**
   * title appBar 显示的标题文字
   * backIcon  appBar 显示的返回键图标
   * actions  appBar 最右侧的图标集合
   */
  Widget buildBackAndOtherBar(String title,
      {backIcon = Icons.arrow_back_ios, List<Widget> actions}) {
    return appBar = AppBar(
      backgroundColor: CommonColors.base_red,
      centerTitle: true,
      //在标题前面显示的一个控件，在首页通常显示应用的 logo；在其他界面通常显示为返回按钮
      leading: IconButton(
          icon: Icon(backIcon),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      //Toolbar 中主要内容，通常显示为当前界面的标题文字
      title: Text(title),
      //标题右侧显示的按钮组
      actions: actions,
    );
  }




  //24cf5f
  FlatButton buildFlatButton(String text, @required VoidCallback onPressed) {
    return FlatButton(
      color: CommonColors.base_red_normal,
      highlightColor: CommonColors.base_red_press,
      colorBrightness: Brightness.dark,
      splashColor: Colors.grey,
      child: Text(text),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: onPressed,
    );
  }

  FlatButton buildWhiteFlatButton(
      String text, @required VoidCallback onPressed) {
    return FlatButton(
      color: CommonColors.base_white_normal,
      highlightColor: CommonColors.base_white_press,
      colorBrightness: Brightness.dark,
      splashColor: Colors.grey,
      child: Text(text,
          style: TextStyle(
            //文字的颜色
            color: CommonColors.base_red_normal,
          )),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: onPressed,
    );
  }

  ProgressView buildProgressView() {
    return ProgressView();
  }


   TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: CommonColors.text_dark,
    fontWeight: FontWeight.bold,
  );
   TextStyle listTitle2 = TextStyle(
    fontSize: Dimens.font_sp16,
    color: CommonColors.text_dark,
  );
  TextStyle listTitle3 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: CommonColors.text_dark,
  );
   TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    color: CommonColors.text_normal,
  );
   TextStyle listContent2 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: CommonColors.text_gray,
  );
  TextStyle listContent3 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: CommonColors.text_gray,
  );
   TextStyle listExtra = TextStyle(
    fontSize: Dimens.font_sp12,
    color: CommonColors.text_gray,
  );
   TextStyle listExtra2 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: CommonColors.text_normal,
  );
}


class Decorations {
  static Decoration bottom = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.33, color: CommonColors.divider)));
}

/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: Dimens.gap_dp5);
  static Widget hGap10 = new SizedBox(width: Dimens.gap_dp10);
  static Widget hGap15 = new SizedBox(width: Dimens.gap_dp15);
  static Widget hGap30 = new SizedBox(width: Dimens.gap_dp30);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: Dimens.gap_dp5);
  static Widget vGap10 = new SizedBox(height: Dimens.gap_dp10);
  static Widget vGap15 = new SizedBox(height: Dimens.gap_dp15);

  static Widget getHGap(double w) {
    return SizedBox(width: w);
  }

  static Widget getVGap(double h) {
    return SizedBox(height: h);
  }
}
