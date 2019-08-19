import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/beans/course_bean.dart';
import 'package:flutter_x/common/common.dart';
import 'package:flutter_x/main/art_des_page.dart';
import 'package:flutter_x/main/course_list_page.dart';
import 'package:flutter_x/main/login_page.dart';
import 'package:flutter_x/route/scale_route.dart';
import 'package:flutter_x/view/web_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RouteUtil {
  static void goMain(BuildContext context) {
    pushReplacementNamed(context, Constant.routeMain);
  }

  static void goLogin(BuildContext context) {
    pushNamed(context, LoginPage());
  }

  static void pushNamed(BuildContext context, Widget page) {
//    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
    Navigator.of(context).push(ScaleRoute(page: page));

  }

  static void pushReplacementNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }

  static void pushPage(
    BuildContext context,
    Widget page, {
    String pageName,
    bool needLogin = false,
  }) {
    if (context == null || page == null) return;
//    Navigator.push(context, new MaterialPageRoute(builder: (context) => page));
    Navigator.of(context).push(ScaleRoute(page: page));
//    Navigator.push(
//        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }
  static void pushCoursePage(BuildContext context, CourseBean model){
   // Navigator.of(context).push(ScaleRoute(page: CourseDesPage(model)));
  }
  static void pushArtPage(BuildContext context,CourseBean bean){
     Navigator.of(context).push(ScaleRoute(page: ArtContentPage(bean)));
  }


  static void pushCoursListPage(BuildContext context, String title){
    Navigator.of(context).push(ScaleRoute(page: CourseListPage(title)));
  }
  static void pushWeb(BuildContext context,
      {String title, String url, bool isHome: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title);
    } else {
      Navigator.push(
          context,
          new CupertinoPageRoute<void>(
              builder: (ctx) => new WebViewWidget(
                    title: title,
                    url: url,
                  )));
    }
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
