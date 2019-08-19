import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderItemBean {
  final String labelTitle;
  HeaderItemBean(this.labelTitle);
}

final List<HeaderItemBean> _allPages = <HeaderItemBean>[
  new HeaderItemBean("主页"),
  new HeaderItemBean("发现"),
  new HeaderItemBean("消息"),
  new HeaderItemBean("附近"),
];

/**
 * Container 官方给出的简介，是一个结合了绘制（painting）、定位（positioning）以及尺寸（sizing）widget的widget。
 */
class TabBarTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleLayout = new TabBar(
      //tabs 的长度超出屏幕宽度后，TabBar，是否可滚动
      //设置为false tab 将平分宽度，为true tab 将会自适应宽度
      isScrollable: true,
      ////每个label的padding值
      labelPadding: EdgeInsets.all(12.0),
      ///指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
      indicatorSize: TabBarIndicatorSize.label,
      //设置所有的tab
      tabs: _allPages
          .map((HeaderItemBean page) => new Tab(text: page.labelTitle))
          .toList(),
    );

    Widget body = new TabBarView(
        children: _allPages.map((HeaderItemBean page) {
      return Container(
        child: Text(page.labelTitle),
      );
    }).toList());

    return new DefaultTabController(
        length: _allPages.length,
        child: new Scaffold(
          appBar: new AppBar(
            //标题是否居中显示，默认值根据不同的操作系统，显示方式不一样,true居中 false居左
            centerTitle: true,
            //Toolbar 中主要内容，通常显示为当前界面的标题文字
            title: titleLayout,
          ),
          body: body,
        ));
  }

}
