import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

import 'demo_swiper_custom_layout.dart';
import 'demo_swiper_default.dart';
import 'demo_swiper_default_scal.dart';
import 'demo_swiper_default_scal2.dart';
import 'demo_swiper_default_tink.dart';
import 'demo_swiper_dot.dart';
import 'demo_swiper_num.dart';

class SwiperIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SwiperIndexPageState();
  }
}

class SwiperIndexPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("dialog", backIcon: Icons.arrow_back_ios);
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      child: new Column(
        //水平方向填充
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
          ),
          //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
          buildWhiteFlatButton("默认圆点指示器", () {
            RouteUtil.pushPage(context, SwiperViewDefaultPage());
          }),
          buildWhiteFlatButton("自定义圆点指示器", () {
            RouteUtil.pushPage(context, SwiperViewDotPage());
          }),
          buildWhiteFlatButton("数字指示器", () {
            RouteUtil.pushPage(context, SwiperViewNumPage());
          }),
          buildWhiteFlatButton("缩放效果的轮播", () {
            RouteUtil.pushPage(context, SwiperViewDefaultScalPage());
          }),
          buildWhiteFlatButton("缩放视差效果的轮播", () {
            RouteUtil.pushPage(context, SwiperViewDefaultScal2Page());
          }),
          buildWhiteFlatButton("渐变视差效果的轮播", () {
            RouteUtil.pushPage(context, SwiperViewTinkPage());
          }),

          buildWhiteFlatButton("自定义视差效果的轮播", () {
            RouteUtil.pushPage(context, SwiperCustomLayoutPage());
          }),
          buildWhiteFlatButton("IndicatorPage", () {
          }),



        ],
      ),
    );
  }
}
