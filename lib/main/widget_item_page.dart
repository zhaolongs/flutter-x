import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/beans/beans.dart';
import 'package:flutter_x/beans/course_bean.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/demo/androidview/demo_androidview_index.dart';
import 'package:flutter_x/demo/anima/demo_anima_index.dart';
import 'package:flutter_x/demo/bar/demo_bar.dart';
import 'package:flutter_x/demo/demo_cir_border.dart';
import 'package:flutter_x/demo/demo_date.dart';
import 'package:flutter_x/demo/demo_dialog.dart';
import 'package:flutter_x/demo/demo_timer.dart';
import 'package:flutter_x/demo/demo_toast.dart';
import 'package:flutter_x/demo/gesture/demo_gesture.dart';
import 'package:flutter_x/demo/demo_lnk_well.dart';
import 'package:flutter_x/demo/menu/demo_menu_index.dart';
import 'package:flutter_x/demo/native/demo_flutter_native_index.dart';
import 'package:flutter_x/demo/swiper/demo_swiper.dart';
import 'package:flutter_x/demo/swiper/demo_swiper_default.dart';
import 'package:flutter_x/demo/pageview/demo_pageview.dart';
import 'package:flutter_x/demo/pageview/demo_pageview_left.dart';
import 'package:flutter_x/demo/demo_progress.dart';
import 'package:flutter_x/demo/demo_timerpick.dart';
import 'package:flutter_x/http/http_home_manager.dart';
import 'package:flutter_x/res/strings.dart';
import 'package:flutter_x/utils/route_utils.dart';
import 'package:flutter_x/utils/toast.dart';
import 'package:flutter_x/utils/utils.dart';
import 'package:flutter_x/view/article_item_widget.dart';
import 'package:flutter_x/view/header_item_widget.dart';
import 'package:flutter_x/view/refresh_scaffold_widget.dart';
import 'package:flutter_x/view/repos_item_widget.dart';
import 'package:flutter_x/view/progress_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

bool isHomeInit = true;

class WidgetItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WidgetItemPageState();
  }
}

class WidgetItemPageState extends BasePage {
  bool mIsLoading = false;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    LogUtil.e("HomePage build......");
    RefreshController _controller = new RefreshController();
    return new DefaultTabController(
        length: 1,
        child: new Scaffold(
          appBar: new MyAppBar(
            backgroundColor: CommonColors.base_red,
            //标题是否居中显示，默认值根据不同的操作系统，显示方式不一样,true居中 false居左
            centerTitle: true,
            //Toolbar 中主要内容，通常显示为当前界面的标题文字
            title: Text("组件"),
            //一个 Widget 列表，代表 Toolbar 中所显示的菜单，对于常用的菜单，通常使用 IconButton 来表示；
            // 对于不常用的菜单通常使用 PopupMenuButton 来显示为三个点，点击后弹出二级菜单
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.search),
                  onPressed: () {
                    LogUtil.v("search click ");
//                    NavigatorUtil.pushPage(context, new SearchPage(),
//                        pageName: "SearchPage");
                  })
            ],
          ),
          body: new RefreshScaffold(
            isLoading: mIsLoading,
            controller: _controller,
            enablePullUp: false,
            onRefresh: () {
              print("refresh");
              mIsLoading = false;
              setState(() {
                LogUtil.v("更新数据");
              });
              return Future.delayed(new Duration(seconds: 1));
            },
            child: ListView(
              children: <Widget>[
                buildItemUi1("# 1.1 第一阶段 之 【环境配制相关】", 0, context),
                buildItemUi1("# 1.2 第一阶段 之 Flutter 【ui 基础 1】", 1, context),
                buildItemUi1("# 1.3 第一阶段 之 Flutter 【ui 基础 2】", 2, context),
                buildItemUi1("# 1.4 第一阶段 之 Flutter 【ui 基础 3】", 3, context),
                buildItemUi1("# 2 第二阶段 之 基础功能篇", 4, context),
                buildItemUi1("# 3 第三阶段 之 动画功能篇", 5, context),
                buildItemUi1("# 4 第四阶段 之 中级功能篇", 6, context),
                buildBottomWidget(),
              ],
              shrinkWrap: true,
            ),
          ),
//          drawer: new Drawer(
//            child: new MainLeftPage(),
//          ),
        ));
  }

  Widget buildBottomWidget() {
    return Container(
      child: Text(
        "已到底了哈!!!",
        style: listExtra,
        //文字居中
        textAlign: TextAlign.center,
      ),
      //Text 居中
      alignment: Alignment.center,
      height: 40,
    );
  }

  buildItemUi1(String title, int flag, BuildContext context) {
    return Column(
      children: <Widget>[
        HeaderItem(
          leftIcon: Icons.keyboard,
          title: title,
          isRight: false,
        ),
        Container(
          color: CommonColors.divider,
          child: buildCoulmn(context, flag),
        )
      ],
    );
  }

  static List ui_data_1 = [
    {
      "title": "1.1.1 从配制开发环境再到开发第一个应用",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/93532770"
    },
    {
      "title": "1.1.2 使用Android Studio 创建第一个应用",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94166350"
    },
    {
      "title": "1.1.3 flutter 开发应用第一个页面",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94166523"
    },
    {
      "title": "1.1.4 flutter 之 Dart语言 基础",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94166683"
    },
  ];
  static List ui_data_2 = [
    {
      "title": "1.2.1 主题 Flutter MaterialApp 简述",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94166904"
    },
    {
      "title": "1.2.2 主布局 Flutter Scaffold",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94167100"
    },
    {
      "title": "1.2.3 AppBar 简述",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94167192"
    },
    {
      "title": "1.2.4 Container 容器",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94167281"
    },
    {
      "title": "1.2.5 StatefulWidget和StatelessWidget",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94167384"
    },
    {
      "title": "1.2.6 Text 文本显示",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94347464"
    },
    {
      "title": "1.2.7 Button 按钮",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94347588"
    },
    {
      "title": "1.2.8 TextField 文本输入框",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94347668"
    },
    {
      "title": "1.2.9 开关Switch与复选框Checkbox",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94347934"
    },
    {
      "title": "1.2.10 Radio 单选框",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94348140"
    },
    {
      "title": "1.2.11 水平和垂直布局详解",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94348335"
    },
    {
      "title": "1.2.12 Stack 帧布局，层叠堆放",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94348405"
    },
    {"title": "1.2.13 Form 表单 创建第一个应用"},
    {
      "title": "1.2.14 一个登录页面 ",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94348582"
    },
  ];
  static List ui_data_3 = [
    {
      "title": "1.3.1 flutter Image 图片加载",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94426396"
    },
    {
      "title": "1.3.2 flutter ScrollView 滑动",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94426582"
    },
    {
      "title": "1.3.3 flutter PageView 分页切换",
      "pageUrl": "",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94484152",
      "demo": PageViewPage()
    },
    {"title": "1.3.4 flutter CustomScrollView 自定义滑动效果", "pageUrl": ""},
    {
      "title": "1.3.5 flutter listView",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94547555"
    },
    {
      "title": "1.3.6 flutter listView 下拉刷新与上拉加载更多",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94550776"
    },
    {
      "title": "1.3.7 flutter progress",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94581899",
      "demo": PorgressViewPage()
    },
    {
      "title": "1.3.8 flutter tabbarview",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94966423",
      "demo": BarIndexPage()
    },
    {"title": "1.3.9 flutter InkWell", "demo": InkWellPage()},
    {"title": "1.3.10 flutter 设置圆角边框", "demo": CirBorderContainerPage()},

  ];
  static List ui_data_4 = [
    {
      "title": "1.4.1 PickView 时间选择器",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94614825",
      "demo": TimerPickPage()
    },
    {"title": "1.4.2 PickView 城市选择器"},
    {
      "title": "1.4.3 弹框 dialog",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94592237",
      "demo": DialogPage()
    },
    {"title": "1.4.4 轮播图", "demo": SwiperIndexPage()},
    {"title": "1.4.5 导航栏菜单", "demo": MenuIndexPage()},
    {"title": "1.4.6 Toast 消息提示框", "demo": ToastPage()},
  ];
  static List ui_data_5 = [
    {
      "title": "2.1.1 手势处理",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94980702",
      "demo": GestureIndexPage()
    },
    {
      "title": "2.2.1 日志输出 LogUtil",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94986869"
    },
    {"title": "2.2.3 计时器", "demo": TimerPage()},
    {"title": "2.2.4 日期处理", "demo": DataPage()},
  ];
  static List ui_data_6 = [
    {
      "title": "3.1 动画专题",
      "pageUrl": "https://blog.csdn.net/zl18603543572/article/details/94980702",
      "demo": AnimaIndexPage()
    },
  ];
  static List ui_data_7 = [
    {
      "title": "4.1 flutter 调用原生代码方法",
      "demo": FlutterNativePage()
    },
    {
      "title": "4.2 flutter 调用原生view",
      "demo": AndroidViewPage()
    },
  ];
  buildCoulmn(BuildContext context, int flag) {
    switch (flag) {
      case 0:
        return Column(
          children: buildItemColumn(ui_data_1, context),
        );
      case 1:
        return Column(
          children: buildItemColumn(ui_data_2, context),
        );
      case 2:
        return Column(
          children: buildItemColumn(ui_data_3, context),
        );
      case 3:
        return Column(
          children: buildItemColumn(ui_data_4, context),
        );
      case 4:
        return Column(
          children: buildItemColumn(ui_data_5, context),
        );
      case 5:
        return Column(
          children: buildItemColumn(ui_data_6, context),
        );
      case 6:
        return Column(
          children: buildItemColumn(ui_data_7, context),
        );
    }
  }

  buildItemColumn(List dataList, BuildContext context) {
    List<Widget> widgetList = new List();
    for (int i = 0; i < dataList.length; i++) {
      var data = dataList[i];
      widgetList.add(buildListTitle(data['title'], onTap: () {
        String url = data['pageUrl'];
        if (url != null) {
          RouteUtil.pushWeb(context, title: "详情", url: url);
        } else {
          Toast.toast(
            context,
            msg: '暂无详情',
          );
        }
        LogUtil.v("onTab ");
      }, onPressed: () {
        LogUtil.v("onPressed ");
        Widget page = data['demo'];
        if (page == null) {
          Toast.toast(
            context,
            msg: '暂无Demo',
          );
        } else {
          RouteUtil.pushPage(context, page);
        }
      }));
    }
    return widgetList;
  }

  buildListTitle(String title, {Icon icon, onTap, onPressed}) {
    return new ListTile(
        title: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon == null ? Container() : icon,
            new SizedBox(width: 10.0),
            new Expanded(
                child: new Text(
              title ?? "推荐",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ))
          ],
        ),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              onPressed: onPressed,
              textColor: Colors.blue,
              child: Text("demo"),
            ),
            IconButton(
              icon: new Icon(
                Icons.keyboard_arrow_right,
                color: Colors.blue,
              ),
              onPressed: onTap,
            ),
          ],
        ));
  }

  buildGird(BuildContext context) {
    return GridView.builder(
        //解决嵌套不滑动问题
        physics: new NeverScrollableScrollPhysics(),
        //内容包裹
        shrinkWrap: true,
        //子条目个数
        itemCount: 3,
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            mainAxisSpacing: 20.0,
            //横轴间距
            crossAxisSpacing: 10.0,
            //子组件宽高长度比例
            childAspectRatio: 1.0),
        itemBuilder: (BuildContext context, int index) {
          //Widget Function(BuildContext context, int index)
          return Container(
            color: Colors.blue,
          );
        });
  }
}
