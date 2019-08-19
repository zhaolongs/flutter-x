import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/beans/course_bean.dart';
import 'package:flutter_x/http/http_home_manager.dart';

import 'course_list_item_page.dart';

class CourseListPage extends StatefulWidget {
  String title;

  CourseListPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return new UpRefreshPageViewPageState(title);
  }
}

//BaseAppBarPageState 是封装的一个基类
class UpRefreshPageViewPageState extends BaseAppBarPageState<StatefulWidget> {
  final PageController _controller = new PageController();
  String title;
  int currentPage = 0;

  UpRefreshPageViewPageState(this.title);

  List<CourseBean> mReposModelList;


  @override
  String buildInitState() {
    //buildBackBar( title, backIcon: Icons.arrow_back_ios);
    mReposModelList = new List();
    loadingList();
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
        child: Stack(
          children: <Widget>[
            PageView(
              controller: _controller,
              children: buildPageItemView(),
              //设置滑动方向
              scrollDirection: Axis.vertical,
            ),
            Positioned(
              left: 20,
              top: 40,
              child: Container(
                decoration: new BoxDecoration(
                  //背景
                  color: Colors.transparent,
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                ),
                child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            )
          ],
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
      currentPage = 0;
      loadingList();
    });
  }

  // ignore: slash_for_doc_comments
  /**
   * 上拉加载更多
   */
  Future<Null> _getMore() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('_getMore');
      currentPage++;
      loadingList();
    });
  }

  buildPageItemView() {
    List<Widget> _pages = new List();
    for (int i = 0; i < mReposModelList.length; i++) {
      Widget item = CourseListItemPage(mReposModelList[i]);
      _pages.add(item);
    }
    return _pages;
  }

  void loadingList() {
    homeManager.getCourse((int code, List<CourseBean> list) {
      if (currentPage == 0) {
        mReposModelList = list;
      } else {
        mReposModelList.addAll(list);
      }

      setState(() {});
    }, pageSize: 20, pageIndex: currentPage,loadType: 0);
  }
}
