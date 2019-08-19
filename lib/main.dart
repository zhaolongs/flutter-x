import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'beans/models.dart';
import 'common/common_colors.dart';
import 'common/common.dart';
import 'common/sp_helper.dart';
import 'main/Index_page.dart';
import 'main/home_page.dart';
import 'main/login_page.dart';

void main() => runApp(getMteriaAPP());

/**
 * 在 Flutter 中，一切的显示都是 Widget 。Widget 是一切的基础，作为响应式的渲染，属于 MVVM 的实现机制。
 * Widget 分为 有状态 和 无状态 两种，在 Flutter 中每个页面都是一帧。无状态就是保持在那一帧。而有状态的 Widget 当数据更新时，其实是绘制了新的 Widget，只是 State 实现了跨帧的数据同步保存
 * StatefulWidget，通过调用setState({})方法来刷新控件
 */

/**
 * Flutter 中除了布局的 Widget，还有交互显示的 Widget 和完整页面呈现的Widget。
 * 其中常见的有 MaterialApp、Scaffold、Appbar、Text、Image、FlatButton等。下面简单介绍这些 Wdiget，并完成一个页面。
 */

/**
 * MaterialApp 一般作为APP顶层的主页入口，可配置主题，多语言，路由等
 * Scaffold	一般用户页面的承载Widget，包含appbar、snackbar、drawer等material design的设定。
 * Appbar	一般用于Scaffold的appbar ，内有标题，二级页面返回按键等，当然不止这些，tabbar等也会需要它 。
 * Text	显示文本，几乎都会用到，主要是通过style设置TextStyle来设置字体样式等。
 * RichText	富文本，通过设置TextSpan，可以拼接出富文本场景。
 * TextField	文本输入框 ：new TextField(controller: //文本控制器, obscureText: "hint文本");
 * Image	图片加载: new FadeInImage.assetNetwork( placeholder: "预览图", fit: BoxFit.fitWidth, image: "url");
 * FlatButton	按键点击: new FlatButton(onPressed: () {},child: new Container());
 */
Locale _locale;
Color themeColor = CommonColors.themeColor;

getMteriaAPP() {
  //初始化配置Log
  LogUtil.init(isDebug: Constant.isDebug, tag: Constant.packageBase);
  //初始化配置本地语言环境
  LanguageModel model = SpHelper.getObject<LanguageModel>(Constant.keyLanguage);
  if (model != null) {
    _locale = new Locale(model.languageCode, model.countryCode);
  } else {
    _locale = new Locale('zh', 'CH');
  }
  _locale = new Locale('zh', 'CH');
  /**
   * 本地保存 主题颜色配制
   */
  String _colorKey = SpHelper.getThemeColor();
  if (themeColorMap[_colorKey] != null) themeColor = themeColorMap[_colorKey];

  /**
   * 如果home首页指定了，routes里面就不能有'/'的根路由了，会报错，/指定的根路由就多余了
   * 如果没有home指定具体的页面，那routes里面就傲有/来指定根路由
   * 路由的顺序按照下面的规则来：
   * 1、如果有home，就会从home进入
   * 2、如果没有home，有routes，并且routes指定了入口'/'，就会从routes的/进入
   * 3、如果上面两个都没有，或者路由赵达不到，如果有 onGenerateRoute，就会进入生成的路由
   * 4、如果连上面的生成路由也没有，就会走到onUnknownRoute，不明所以的路由，比如网络连接失败，可以进入断网的页面

   */
  return new MaterialApp(
    //路由配制
    routes: {
      Constant.routeMain: (ctx) => HomePage(),
    },
    //应用默认所显示的界面 页面
    home: new IndexPage(),
    //应用的顶级导航表格，多页面应用 控制页面跳转
    //routes: ,
    // 当系统修改语言的时候，会触发å这个回调
    //onLocaleChanged ：
    // 应用各种 UI 所使用的主题颜色
    theme: CommonColors.themData,
    localizationsDelegates: [
      //此处
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      //此处
      const Locale('zh', 'CH'),
      const Locale('en', 'US'),
    ],
    debugShowCheckedModeBanner: false,
    //导航的观察者
    navigatorObservers: <NavigatorObserver>[NewObserver()],
  );
}

//导航的观察者
//导航路由在跳转时的回调，比如 push，pop，remove，replace是，可以拿到当前路由和后面路由的信息
//继承NavigatorObserver
class NewObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    print(route.settings);
    print(previousRoute);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    // TODO: implement didPop
    // 当调用Navigator.pop时回调
    super.didPop(route, previousRoute);
    print(route);
    //route.currentResult获取返回内容
    print(previousRoute);
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    // TODO: implement didRemove
    // 当调用Navigator.Remove时回调
    super.didRemove(route, previousRoute);
    print(route);
    print(previousRoute);
  }
}
/**
 * 1.colorPrimary 应用的主要色调，actionBar默认使用该颜色，Toolbar导航栏的底色

    2.colorPrimaryDark 应用的主要暗色调，statusBarColor默认使用该颜色

    3.statusBarColor 状态栏颜色，默认使用colorPrimaryDark

    4.windowBackground 窗口背景颜色

    5.navigationBarColor 底部栏颜色

    6.colorForeground 应用的前景色，ListView的分割线，switch滑动区默认使用该颜色

    7.colorBackground 应用的背景色，popMenu的背景默认使用该颜色

    8.colorAccent CheckBox，RadioButton，SwitchCompat等一般控件的选中效果默认采用该颜色

    9.colorControlNormal CheckBox，RadioButton，SwitchCompat等默认状态的颜色。

    10.colorControlHighlight 控件按压时的色调

    11.colorControlActivated 控件选中时的颜色，默认使用colorAccent

    12.colorButtonNormal 默认按钮的背景颜色

    13.editTextColor：默认EditView输入框字体的颜色。

    14.textColor Button，textView的文字颜色

    15.textColorPrimaryDisableOnly RadioButton checkbox等控件的文字

    16.textColorPrimary 应用的主要文字颜色，actionBar的标题文字默认使用该颜色

    17.colorSwitchThumbNormal: switch thumbs 默认状态的颜色. (switch off)

 */
