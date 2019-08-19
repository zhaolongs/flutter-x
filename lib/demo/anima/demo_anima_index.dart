import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

import 'GrowTransitionDemo.dart';
import 'PositionedTransitionDemo.dart';
import 'PositionedTransitionOfficalDemo.dart';
import 'SizeTransitionDemo.dart';
import 'StaggerAnimation.dart';
import 'demo_v2_anima_fade.dart';
import 'demo_v2_anima_pos.dart';
import 'demo_v2_anima_rota.dart';
import 'demo_v2_anima_scale.dart';
import 'demo_v2_anima_size.dart';
import 'demo_v2_anima_tran.dart';
import 'demo_anima_color_shade.dart';
import 'demo_anima_padding.dart';
import 'demo_anima_rota_tran.dart';
import 'demo_anima_rota_tran2.dart';
import 'demo_anima_scal_revertweet.dart';
import 'demo_anima_scale.dart';
import 'demo_anima_scale_tran.dart';
import 'demo_crossfade.dart';
import 'demo_curved_scaleImage.dart';
import 'demo_fade_transition.dart';
import 'drawer.dart';

class AnimaIndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AnimaIndexPageState();
  }
}

class AnimaIndexPageState extends BaseAppBarPageState<StatefulWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> tween;
  AnimationController controller;

  @override
  String buildInitState() {
    buildBackBar("动画", backIcon: Icons.arrow_back_ios);

    /*创建动画控制类对象*/
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    /*创建补间对象*/
    tween = new Tween(begin: 0.0, end: 1.0).animate(controller) //返回Animation对象
      ..addListener(() {
        //添加监听
        setState(() {
          print(tween.value); //打印补间插值
        });
      });
    controller.forward(); //执行动画

    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
          ),

          Row(
            children: <Widget>[
              Container(
                alignment: Alignment(0, 0),
                child: Container(
                  color: Colors.grey,
                  width: 250.0 * controller.value,
                  height: 50.0,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
          buildWhiteFlatButton("SlideTransition 平移", () {
            RouteUtil.pushPage(context, SlideTransitionPage());
          }),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          buildWhiteFlatButton("RotationTransition 旋转", () {
            RouteUtil.pushPage(context, RotationTransitionPage());
          }),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          buildWhiteFlatButton("ScaleTransition 缩放", () {
            RouteUtil.pushPage(context, ScaleTransitionPage());
          }),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          buildWhiteFlatButton("SizeTransitionPage 缩放", () {
            RouteUtil.pushPage(context, SizeTransitionPage());
          }),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          buildWhiteFlatButton("FadeTransitionPage 渐变", () {
            RouteUtil.pushPage(context, FadeTransitionPage());
          }),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          buildWhiteFlatButton("RelativeRectTweenPage ", () {
            RouteUtil.pushPage(context, RelativeRectTweenPage());
          }),

          buildWhiteFlatButton("点击图片切换", () {
            RouteUtil.pushPage(context, AnimatedCrossFadeDemo());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("AnimatedPaddingPage", () {
            RouteUtil.pushPage(context, AnimatedPaddingPage());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("CurvedScaleImageDemo", () {
            RouteUtil.pushPage(context, CurvedScaleImageDemo());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("FTDemo", () {
            RouteUtil.pushPage(context, FTDemo());
          }),

          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("GrowTransitionDemo", () {
            RouteUtil.pushPage(context, GrowTransitionDemo());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("PTDemo", () {
            RouteUtil.pushPage(context, PTDemo());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("PTDemo2", () {
            RouteUtil.pushPage(context, PTDemo2());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("缩放动画 ReverseTween", () {
            RouteUtil.pushPage(context, ReverseTweenPage());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("旋转动画 RotationTransition", () {
            RouteUtil.pushPage(context, RotaTransDemo());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("旋转动画 RotationTransition Animation 配合", () {
            RouteUtil.pushPage(context, RotaTransAndAimaDemo());
          }),

          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("缩放动画 ScaleTransition", () {
            RouteUtil.pushPage(context, ScaleTransDemo());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("缩放动画 Tween", () {
            RouteUtil.pushPage(context, AnimaScalePage());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("SizeTDemo", () {
            RouteUtil.pushPage(context, SizeTDemo());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("StaggerDemo", () {
            RouteUtil.pushPage(context, StaggerDemo());
          }),
          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("颜色渐变动画", () {
            RouteUtil.pushPage(context, AnimaShadePage());
          }),

          Padding(
            padding: EdgeInsets.all(4),
          ),
          buildWhiteFlatButton("BackdropDemo", () {
            RouteUtil.pushPage(context, BackdropDemo());
          }),
        ],
      ),
    );
  }
}
