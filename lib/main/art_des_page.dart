import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fai_webview/flutter_fai_webview.dart';
import 'package:flutter_html/flutter_html.dart';

//import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/beans/beans.dart';
import 'package:flutter_x/beans/course_bean.dart';
import 'package:flutter_x/common/common_colors.dart';

/**
 * 文章详情页面
 * 加载 html 页面 FaiWebViewWidget 插件 功能详情在这里 https://blog.csdn.net/zl18603543572/article/details/96585707
 */
class ArtContentPage extends StatefulWidget {
  CourseBean bean;

  ArtContentPage(this.bean);

  @override
  State<StatefulWidget> createState() {
    return new ArtContentPageState(bean);
  }
}

class ArtContentPageState extends BaseAppBarPageState<StatefulWidget> {
  ArtContentPageState(this.mCourseBean);

  CourseBean mCourseBean;
  UserModel mCreatUserBean;

  @override
  String buildInitState() {
    buildBackAndOtherBar("文章详情");
    homeManager
        .getCourseDes(mCourseBean.courseUid, mCourseBean.courseCreateUuserUid,
            (String artContent) {
      mCourseBean.artContent = artContent;
      setState(() {});
    }, (int code, String errMessage) {});
    homeManager.getCourseUserInfo(mCourseBean.courseCreateUuserUid,
        (UserModel bean) {
      mCreatUserBean = bean;
      setState(() {});
    }, (int code, String errMessage) {});
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget widget = new Container(
      color: Colors.white,
      child: Center(
        child: buildProgressView(),
      ),
    );
    if (mCourseBean.artContent != null) {
      widget = buildArtContentWidget();
//      widget= AndroidView(viewType: 'com.flutter_to_native_view');
    }
    return widget;
  }

  GlobalKey formKey = new GlobalKey<ScrollableState>();

  Widget buildArtContentWidget() {
    Widget rootWidget = SingleChildScrollView(
      key: formKey,
      child: Center(
        child: Column(
          //水平方向填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildArtTitleWidget(),
            buildArtUserWidget(),
            buildArtFlagWidget(),
            buildArtDesWidget()
          ],
        ),
      ),
    );

    return rootWidget;
  }

  //文章标题
  buildArtTitleWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 14, right: 14),
      child: Text(
        mCourseBean.courseTitle,
        style: listTitle,
      ),
    );
  }

  //文章作者想着
  buildArtUserWidget() {
    if (mCreatUserBean == null) {
      return Container();
    }
    return new Container(
      padding: EdgeInsets.only(left: 12, top: 16, right: 16, bottom: 10),
      child: new Row(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: new ClipOval(
              child: CachedNetworkImage(
                  width: 46,
                  height: 46,
                  fit: BoxFit.fill,
                  imageUrl: mCreatUserBean.headerImagUrl,
                  placeholder: (BuildContext context, String url) {
                    return buildProgressView();
                  },
                  errorWidget:
                      (BuildContext context, String url, Object error) {
                    return new Icon(Icons.error);
                  }),
            ),
          ),
          new Expanded(
              flex: 1,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    mCreatUserBean.nike,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: listTitle3,
                  ),
                  Gaps.vGap10,
                  new Text(
                    mCreatUserBean.sign == null
                        ? "他很懒，什么也没有留下"
                        : mCreatUserBean.sign,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: listContent3,
                  ),
                  Gaps.vGap5,
                ],
              )),
          new Container(
            margin: EdgeInsets.only(right: 10),
            height: 22.0,
            width: 60.0,
            alignment: Alignment.center,
            child: FlatButton(
              color: CommonColors.base_green,
              highlightColor: CommonColors.base_green_press,
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text(
                "+关注",
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0)),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  //题记
  buildArtFlagWidget() {
    return Container();
  }

  double webViewHeight = 100;



  callBack(int code, String msg, content) {
    //加载页面完成后 对页面重新测量的回调

    if (code == 201) {
      webViewHeight = content*1.0;
      webViewHeight=600;
      print("webViewHeight "+webViewHeight.toString());
    } else {
      //其他回调
    }

    String message = "回调：code[" + code.toString() + "]; msg[" + msg.toString() + "]";
    LogUtil.v(message);
    setState(() {

    });
  }
  String htmlUrl = "https://blog.csdn.net/zl18603543572";
  buildArtDesWidget() {
//    if(0==0){
//      return Container();
//    }
//    FaiWebViewWidget webViewWidget = FaiWebViewWidget(
//      //webview 加载网页链接
//      //url: htmlUrl,
//      htmlBlockData: mCourseBean.artContent,
//      //webview 加载信息回调
//      callback: callBack,
//      //输出日志
//      isLog: true,
//    );
    //使用插件 FaiWebViewWidget
    FaiWebViewWidget webViewWidget = FaiWebViewWidget(
      //webview 加载网页链接
      url: htmlUrl,
      //webview 加载信息回调
      callback: callBack,
      //输出日志
      isLog: true,
    );
    return Container(
      height: webViewHeight,
      padding: EdgeInsets.all(10),
      color:Colors.white,
      child: webViewWidget,
    );

  }
}
