import 'package:flutter/material.dart';

/**
 * 有状态StatefulWidget
 *  继承于 StatefulWidget，通过 State 的 build 方法去构建控件
 */
class BotomeMenumPage extends StatefulWidget {
  ////通过构造方法传值
  BotomeMenumPage();

  //主要是负责创建state
  @override
  BotomeMenumPageState createState() => BotomeMenumPageState();
}

/**
 * 在 State 中,可以动态改变数据
 * 在 setState 之后，改变的数据会触发 Widget 重新构建刷新
 */
class BotomeMenumPageState extends State<BotomeMenumPage> {
  BotomeMenumPageState();

  @override
  void initState() {
    ///初始化，这个函数在生命周期中只调用一次
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //构建页面
    return buildBottomTabScaffold();
  }

  //当前显示页面的
  int currentIndex = 0;

  //底部导航栏显示的内容
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      title: Text("首页"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[600],
      icon: Icon(Icons.format_indent_increase),
      title: Text("发现"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[800],
      icon: Icon(Icons.message),
      title: Text("动态"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.blue[900],
      icon: Icon(Icons.person),
      title: Text("我的"),
    ),
  ];

  //点击导航项是要显示的页面
  final pages = [
    ChildItemView("首页"),
    ChildItemView("发现"),
    ChildItemView("动态"),
    ChildItemView("我的")
  ];

  Widget buildBottomTabScaffold() {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        //所以一般都是使用fixed模式，此时，导航栏的图标和标题颜色会使用fixedColor指定的颜色，
        // 如果没有指定fixedColor，则使用默认的主题色primaryColor
        type: BottomNavigationBarType.fixed,
        //底部菜单点击回调
        onTap: (index) {
          _changePage(index);
        },
      ),
      //对应的页面
      body: pages[currentIndex],
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}

//子页面
class ChildItemView extends StatefulWidget {
  String _title;

  ChildItemView(this._title);

  @override
  _ChildItemViewState createState() => _ChildItemViewState();
}

class _ChildItemViewState extends State<ChildItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(widget._title)),
    );
  }
}
