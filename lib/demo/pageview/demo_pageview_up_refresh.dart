

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class UpRefreshPageViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UpRefreshPageViewPageState();
  }
}
//BaseAppBarPageState 是封装的一个基类
class UpRefreshPageViewPageState
    extends BaseAppBarPageState<StatefulWidget> {
  final PageController _controller = new PageController();


  @override
  String buildInitState() {
    buildBackBar("pageView 下拉刷新 ", backIcon: Icons.arrow_back_ios);
    //设置pageView 滑动监听
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {

    return RefreshIndicator(
      //下拉刷新触发方法
      onRefresh: _onRefresh,
      //设置listView
      child: Container(
        child: PageView(
          controller: _controller,
          children: buildPageItemView(),
          //设置滑动方向
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }

  // ignore: slash_for_doc_comments
  /**
   * 下拉刷新方法,为list重新赋值
   */
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');
      setState(() {});
    });
  }

  // ignore: slash_for_doc_comments
  /**
   * 上拉加载更多
   */
  Future<Null> _getMore() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('_getMore');
      setState(() {});
    });
  }

  buildPageItemView() {
    List<Widget> _pages = new List();
    for (int i = 0; i < 10; i++) {
      Widget item = new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: new CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          imageUrl:
              "http://b-ssl.duitang.com/uploads/item/201311/02/20131102150044_YGB5u.jpeg",
          placeholder: (context, url) => new SizedBox(
            width: 24.0,
            height: 24.0,
            child: new CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
      );
      _pages.add(item);
    }
    return _pages;
  }
}
