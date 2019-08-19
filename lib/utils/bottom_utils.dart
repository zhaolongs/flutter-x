import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/demo/menu/demo_bottom_menu_float.dart';
import 'package:flutter_x/main/home_item_page.dart';
import 'package:flutter_x/main/my_page.dart';
import 'package:flutter_x/main/widget_item_page.dart';
import 'package:flutter_x/utils/toast.dart';

class BottomMenuUtils {
  static BottomMenuUtils _instance;

  factory BottomMenuUtils.getDefault() {
    if (_instance == null) {
      _instance = new BottomMenuUtils();
    }
    return _instance;
  }

  BottomMenuUtils();

  static final _titls = ["首页", "发现", "添加", "组件", "我的"];

  //导航栏使用到的图标
  static List _icons = [
    Icons.home,
    Icons.format_indent_increase,
    Icons.add,
    Icons.widgets,
    Icons.person
  ];

  //当前显示页面的
  int currentIndex = 0;

  //底部导航栏显示的内容
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(_icons[0]),
      title: Text(_titls[0]),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[600],
      icon: Icon(_icons[1]),
      title: Text(_titls[1]),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[800],
      icon: Icon(_icons[2]),
      title: Text(_titls[2]),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[800],
      icon: Icon(_icons[3]),
      title: Text(_titls[3]),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[900],
      icon: Icon(_icons[4]),
      title: Text(_titls[4]),
    ),
  ];

  //点击导航项是要显示的页面
  final pages = [
    new HomeItemPage(),
    new Container(
      color: Colors.red,
    ),
    new Container(
      color: Colors.grey,
    ),
    new WidgetItemPage(),
    new MyPage()
  ];

  void showAlertDialog(BuildContext context) {
    TextField textField = TextField(
      //文字样式设置
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      //设置边框属性
      //默认的有底部下划线的
      decoration: InputDecoration(
        //输入前的提示文字
        hintText: "请输入留言",
        //去掉下划线
        border: InputBorder.none,
        //输入前的提示文字样式
        hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
      ),
    );
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('请留言'),
            content: Container(
              padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
              //设置 child 居中
              alignment: Alignment(0, 0),
              height: 55,
              width: 300,
              //边框设置
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: Colors.grey),
              ),
              child: textField,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('提交'),
                onPressed: () {
                  Toast.toast(context, msg: "已提交");
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget buildBottomTabScaffold(BuildContext context, int tabIndex, callBack) {
    currentIndex = tabIndex;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: tabIndex,
        //所以一般都是使用fixed模式，此时，导航栏的图标和标题颜色会使用fixedColor指定的颜色，
        // 如果没有指定fixedColor，则使用默认的主题色primaryColor
        type: BottomNavigationBarType.fixed,
        //底部菜单点击回调
        onTap: (index) {
          if (index == 2) {
            showAlertDialog(context);
          } else {
            if (index != currentIndex) {
              callBack(index);
            }
          }
        },
      ),
      //对应的页面
      body: pages[tabIndex],
    );
  }

  /// 不规则菜单栏
  Widget buildBottomTab2Scaffold(BuildContext context, int index, callback) {
    currentIndex = index;
    return SizedBox(
        height: 100,
        child: Scaffold(
          //对应的页面
          body: pages[currentIndex],
          //appBar: AppBar(title: const Text('Bottom App Bar')),
          //悬浮按钮的位置
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //悬浮按钮
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              print("add press ");
              showAlertDialog(context);
//              if (2 != currentIndex) {
//                callback(2);
//              }
            },
          ),
          //其他菜单栏
          bottomNavigationBar: BottomAppBar(
            //悬浮按钮 与其他菜单栏的结合方式
            shape: CircularNotchedRectangle(),
            // FloatingActionButton和BottomAppBar 之间的差距
            notchMargin: 6.0,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildBotomItem(currentIndex, 0, Icons.home, "首页", callback),
                buildBotomItem(
                    currentIndex, 1, Icons.library_music, "发现", callback),
                buildBotomItem(currentIndex, 2, null, "添加", callback),
                buildBotomItem(currentIndex, 3, Icons.email, "组件", callback),
                buildBotomItem(currentIndex, 4, Icons.person, "我的", callback),
              ],
            ),
          ),
        ));
  }

// ignore: slash_for_doc_comments
  /**
   * @param selectIndex 当前选中的页面
   * @param index 每个条目对应的角标
   * @param iconData 每个条目对就的图标
   * @param title 每个条目对应的标题
   */
  buildBotomItem(
      int selectIndex, int index, IconData iconData, String title, callback) {
    //未选中状态的样式
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.grey);
    MaterialColor iconColor = Colors.grey;
    double iconSize = 20;
    EdgeInsetsGeometry padding = EdgeInsets.only(top: 8.0);

    if (selectIndex == index) {
      //选中状态的文字样式
      textStyle = TextStyle(fontSize: 13.0, color: Colors.blue);
      //选中状态的按钮样式
      iconColor = Colors.blue;
      iconSize = 25;
      padding = EdgeInsets.only(top: 6.0);
    }
    Widget padItem = SizedBox();
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize,
                ),
                Text(
                  title,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      );
    }
    Widget item = Expanded(
      flex: 1,
      child: new GestureDetector(
        onTap: () {
          if (index != currentIndex) {
            callback(index);
          }
        },
        child: SizedBox(
          height: 52,
          child: padItem,
        ),
      ),
    );
    return item;
  }

  //
  //当前选中的页面
  //导航栏高度
  double _height = 52.0;

  //悬浮图标半径
  double _floatRadius;

  //移动补间
  double _moveTween = 0.0;

  //浮动图标与圆弧之间的间隙
  double _padding = 10.0;

  //动画控制器
  AnimationController _animationController;

  //移动动画
  Animation<double> _moveAnimation;

  init(widget) {
    _floatRadius = _height * 2 / 3;
    _animationController = AnimationController(
        vsync: widget, duration: Duration(milliseconds: 400));
  }

  buildFloatMenuFunction(BuildContext context, int index, double moveTween,
      callback, moveCallback) {
    currentIndex = index;
    _moveTween = moveTween;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    double width = MediaQuery.of(context).size.width;
    double singleWidth = width / _icons.length;
    double posTop = _animationController.value <= 0.5
        ? (_animationController.value * _height * _padding / 2) -
            _floatRadius / 3 * 2
        : (1 - _animationController.value) * _height * _padding / 2 -
            _floatRadius / 3 * 2;
    print("posTop " + posTop.toString());
    if (posTop > 0) {
      posTop = 0;
    }
    print("posTop--- " + posTop.toString());
    print("bottomPadding " + bottomPadding.toString());
    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Scaffold(
        //对应的页面
        body: pages[currentIndex],
        bottomNavigationBar: Container(
          width: width,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              //浮动图标
              Positioned(
                top: posTop,
                left: _moveTween * singleWidth +
                    (singleWidth - _floatRadius) / 2 -
                    _padding / 2 -
                    2,
                child: DecoratedBox(
                  decoration: ShapeDecoration(shape: CircleBorder(), shadows: [
                    BoxShadow(
                        blurRadius: _padding / 2,
                        offset: Offset(0, _padding / 2),
                        spreadRadius: 0,
                        color: Colors.black26),
                  ]),
                  child: CircleAvatar(
                      radius: _floatRadius - _padding,
                      //浮动图标和圆弧之间设置10pixel间隙
                      backgroundColor: Colors.white,
                      child: Icon(_icons[currentIndex], color: Colors.blue)),
                ),
              ),
              //所有图标
              CustomPaint(
                child: SizedBox(
                  height: _height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _icons
                        .asMap()
                        .map((i, v) => MapEntry(
                            i,
                            GestureDetector(
                              child: buildBotomFloatItem(
                                  currentIndex, i, v, _titls[i]),
                              onTap: () {
                                _switchNav(context, i, callback, moveCallback);
                              },
                            )))
                        .values
                        .toList(),
                  ),
                ),
                painter: ArcPainter(
                    navCount: _icons.length,
                    moveTween: _moveTween,
                    padding: _padding),
              )
            ],
          ),
        ),
      ),
    );
  }

  //切换导航
  _switchNav(BuildContext context, int newIndex, callback, moveCallback) {
    print("switch " + newIndex.toString());
    if (newIndex == 2) {
      showAlertDialog(context);
      return;
    }
    double oldPosition = currentIndex.toDouble();
    double newPosition = newIndex.toDouble();
    if (oldPosition != newPosition &&
        _animationController.status != AnimationStatus.forward) {
      _animationController.reset();
      _moveAnimation = Tween(begin: oldPosition, end: newPosition).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInCubic))
        ..addListener(() {
          moveCallback(_moveAnimation.value);
        })
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            callback(newIndex);
          }
        });
      _animationController.forward();
    }
  }

  buildBotomFloatItem(
      int selectIndex, int index, IconData iconData, String title) {
    //未选中状态的样式
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.grey);
    Color iconColor = Colors.grey;
    Color bgColor = Colors.white;
    EdgeInsetsGeometry padding = EdgeInsets.only(top: 8.0);

    if (selectIndex == index) {
      //选中状态的文字样式
      textStyle = TextStyle(fontSize: 0.0, color: Colors.transparent);
      //选中状态的按钮样式
      iconColor = Colors.transparent;
      bgColor = Colors.transparent;
      padding = EdgeInsets.only(top: 0.0);
    }
    Widget padItem = SizedBox();
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          color: bgColor,
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  color: iconColor,
                ),
                Text(
                  title,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 52,
      child: padItem,
    );
  }

  void dispose() {
    _animationController.dispose();
  }
}
