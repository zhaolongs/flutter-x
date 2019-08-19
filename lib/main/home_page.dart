import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/common/common.dart';
import 'package:flutter_x/common/user_helper.dart';
import 'package:flutter_x/main/widget_item_page.dart';
import 'package:flutter_x/utils/bottom_utils.dart';
import 'package:flutter_x/utils/eventmessage.dart';

import 'home_item_page.dart';
import 'login_page.dart';
import 'my_page.dart';

/**
 * Home页面
 */
class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends BasePage<HomePage>  with SingleTickerProviderStateMixin{


  int bottomBarFlag = 1;
  //当前显示的页面index
  int _tabIndex = 0;
  double _moveTween=0.0;

  //底部显示的tab image
  var tabImages;

  //tab页面
  var _body;

  //底部显示的tab
  var appBarTitles = ['首页', '动弹', '组件', '我的'];

  //底部tab 文字默认显示颜色
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));

  //底部tab 文字选中显示颜色
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));

  List<BottomNavigationBarItem> getBarItems() {
    List<BottomNavigationBarItem> items = new List();
    for (int i = 0; i < appBarTitles.length; i++) {
      items.add(new BottomNavigationBarItem(
          icon: getTabIcon(i), title: getTabTitle(i)));
    }
    return items;
  }

  void initData() {
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/ic_nav_news_normal.png'),
          getTabImage('images/ic_nav_news_actived.png')
        ],
        [
          getTabImage('images/ic_nav_tweet_normal.png'),
          getTabImage('images/ic_nav_tweet_actived.png')
        ],
        [
          getTabImage('images/ic_nav_discover_normal.png'),
          getTabImage('images/ic_nav_discover_actived.png')
        ],
        [
          getTabImage('images/ic_nav_my_normal.png'),
          getTabImage('images/ic_nav_my_pressed.png')
        ]
      ];
    }
    _body = new IndexedStack(
      children: <Widget>[
        new HomeItemPage(),
        new Container(
          color: Colors.red,
        ),
        new WidgetItemPage(),
        new MyPage()
      ],
      index: _tabIndex,
    );
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventMessage.getDefault().register((flag) {
      print("event message " + flag.toString());
      bottomBarFlag = flag;
      UserHelper.getInstance().updateHomeBottomBar(flag);
      setState(() {});
    });
    BottomMenuUtils.getDefault().init(this);
    //首页面底部菜单
    bottomBarFlag = UserHelper.getInstance().getHomeBottomBar();

    initData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EventMessage.getDefault().unregister();
    BottomMenuUtils.getDefault().dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (bottomBarFlag == 1) {
      return new Scaffold(
        backgroundColor: Colors.white,
        body: _body,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: new CupertinoTabBar(
            items: getBarItems(),
            currentIndex: _tabIndex,
            onTap: (index) {
              setState(() {
                _tabIndex = index;
                LogUtil.v("ontap " + index.toString());
              });
            },
          ),
        ),
        //drawer: new MyDrawer(),
      );
    } else if (bottomBarFlag == 2) {
      return BottomMenuUtils.getDefault()
          .buildFloatMenuFunction(context, _tabIndex, _moveTween, (pageIndex) {
        setState(() {
          _tabIndex = pageIndex;
        });
      }, (teew) {
        setState(() {
          _moveTween = teew;
        });
      });
    } else if (bottomBarFlag == 3) {
      return BottomMenuUtils.getDefault().buildBottomTabScaffold(context,_tabIndex,
          (pageIndex) {
        setState(() {
          _tabIndex = pageIndex;
        });
      });
    } else if (bottomBarFlag == 4) {
      return BottomMenuUtils.getDefault().buildBottomTab2Scaffold(context,_tabIndex,
          (pageIndex) {
        setState(() {
          _tabIndex = pageIndex;
        });
      });
    }
  }


}
