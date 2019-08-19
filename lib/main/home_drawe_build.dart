import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/common/user_helper.dart';
import 'package:flutter_x/utils/route_utils.dart';

class HomeBuilder {
  static Widget homeDrawer(BuildContext context, callback) {
    var login = UserHelper.getInstance().isLogin();
    if (!login) {
      return new Stack(
        children: <Widget>[
          Container(
            height: 200,
            child: Image.asset(
              "images/bg_person_header.png",
              fit: BoxFit.fill,
            ),
            constraints: new BoxConstraints.expand(),
          ),
          Center(
            child: FlatButton(
              color: CommonColors.base_white_normal,
              highlightColor: CommonColors.base_white_press,
              colorBrightness: Brightness.dark,
              splashColor: Colors.grey,
              child: Text("登录",
                  style: TextStyle(
                    //文字的颜色
                    color: CommonColors.base_red_normal,
                  )),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                RouteUtil.goLogin(context);
              },
            ),
          ),
        ],
      );
    } else {
      return new ListView(padding: const EdgeInsets.only(), children: <Widget>[
        _drawerHeader(),
        new ClipRect(
          child: new ListTile(
            leading: new CircleAvatar(child: new Text("1")),
            title: new Text('仿开源中国底部菜单'),
            subtitle: new Text("摘自开源中国源码"),
            onTap: () {
              if (callback != null) {
                callback(1);
              }
            },
          ),
        ),
        new ListTile(
          leading: new CircleAvatar(child: new Text("2")),
          title: new Text('动画底部菜单'),
          subtitle: new Text("凸起具有切换动画"),
          onTap: () {
            if (callback != null) {
              callback(2);
            }
          },
        ),
        new ListTile(
          leading: new CircleAvatar(child: new Text("3")),
          title: new Text('规则底部菜单'),
          subtitle: new Text("按钮切换 大小有微动"),
          onTap: () {
            if (callback != null) {
              callback(3);
            }
          },
        ),
        new ListTile(
          leading: new CircleAvatar(child: new Text("4")),
          title: new Text('不规则底部菜单'),
          subtitle: new Text("底部凸起"),
          onTap: () {
            if (callback != null) {
              callback(4);
            }
          },
        ),
        new AboutListTile(
          icon: new CircleAvatar(child: new Text("3")),
          child: new Text("关于我们"),
          applicationName: "Test",
          applicationVersion: "1.0",
          applicationIcon: new Image.asset(
            "images/ymj_jiayou.gif",
            width: 64.0,
            height: 64.0,
          ),
          applicationLegalese: "applicationLegalese",
          aboutBoxChildren: <Widget>[
            new Text("BoxChildren"),
            new Text("box child 2")
          ],
        ),
      ]);
    }
  }

  static Widget _drawerHeader() {
    return new UserAccountsDrawerHeader(
//      margin: EdgeInsets.zero,
      accountName: new Text(
        "SuperLuo",
      ),
      accountEmail: new Text(
        "super_luo@163.com",
      ),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: new AssetImage("images/ic_test.png"),
      ),
      onDetailsPressed: () {
        print("onDetailsPressed");
      },
      otherAccountsPictures: <Widget>[
        new CircleAvatar(
          backgroundImage: new AssetImage("images/ic_test.png"),
        ),
      ],
    );
  }
}
