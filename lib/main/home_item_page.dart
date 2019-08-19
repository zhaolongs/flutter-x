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
import 'package:flutter_x/http/http_home_manager.dart';
import 'package:flutter_x/res/strings.dart';
import 'package:flutter_x/utils/eventmessage.dart';
import 'package:flutter_x/utils/route_utils.dart';
import 'package:flutter_x/utils/utils.dart';
import 'package:flutter_x/view/article_item_widget.dart';
import 'package:flutter_x/view/header_item_widget.dart';
import 'package:flutter_x/view/refresh_scaffold_widget.dart';
import 'package:flutter_x/view/repos_item_widget.dart';
import 'package:flutter_x/view/progress_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_drawe_build.dart';

bool isHomeInit = true;

class HomeItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeItemPageState();
  }
}

class HomeItemPageState extends BasePage {
  List<BannerModel> mBannerModelList;
  List<CourseBean> mReposModelList;
  List<UserModel> mArticleModelList;
  bool mIsLoading = false;

  @override
  void initState() {
    mBannerModelList = new List();
    mReposModelList = new List();
    mArticleModelList = new List();

    loadingDatas();
  }

  Widget buildBanner(BuildContext context, List<BannerModel> list) {
    if (ObjectUtil.isEmpty(list)) {
      return AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: new Container(
          color: Colors.red,
          child: Image.asset(
            "images/default_banner.jpg",
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    }
    //default_banner
    return new AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Swiper(
        indicatorAlignment: AlignmentDirectional.bottomEnd,
        circular: true,
        //轮播时间间隔
        interval: const Duration(seconds: 5),
        //指示器样式
        indicator: NumberSwiperIndicator(),
        children: list.map((model) {
          return new InkWell(
            onTap: () {
              LogUtil.e("BannerModel: " + model.toString());
//              NavigatorUtil.pushWeb(context,
//                  title: model.title, url: model.url);
            },
            child: new Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: new Container(
                    color: Colors.red,
                    child: Image.asset(
                      "images/default_banner.jpg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                  color: Color(0x90FAFAFA),
                ),
                Positioned(
                  left: 20,
                  top: 40,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      width: 70.0,
                      height: 70.0,
                      fit: BoxFit.fill,
                      imageUrl: model.user.headerImagUrl,
                      placeholder: (context, url) => new ProgressView(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  left: 120,
                  top: 40,
                  child: Text(
                    model.user.nike,
                    style: listTitle2,
                  ),
                ),
                Positioned(
                    left: 120,
                    top: 70,
                    right: 12,
                    child: Container(
                      child: Text(
                        Strings.home_head_flag,
                        style: listContent2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    LogUtil.e("HomePage build......");
    RefreshController _controller = new RefreshController();

    return new DefaultTabController(
        length: 1,
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(
            backgroundColor: CommonColors.base_red,
            leading: new Container(
              //嵌套一层设置内边距
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    LogUtil.v("menu click ");
                    //Scaffold.of(context).openDrawer();
                    _scaffoldKey.currentState.openDrawer();
                  }),
            ),
            //标题是否居中显示，默认值根据不同的操作系统，显示方式不一样,true居中 false居左
            centerTitle: true,
            //Toolbar 中主要内容，通常显示为当前界面的标题文字
            title: Text("首页"),
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
              mBannerModelList.clear();
              loadingDatas();
              mIsLoading = false;
              setState(() {
                LogUtil.v("更新数据");
              });
              return Future.delayed(new Duration(seconds: 1));
            },
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return buildBanner(context, mBannerModelList);
                  } else if (index == 1) {
                    return buildItemHeader("推荐阅读", 1);
                  } else if (index == 2) {
                    //listView
                    return buildItemReadWidget();
                  } else if (index == 3) {
                    return buildItemHeader("推荐达人", 2);
                  } else if (index == 4) {
                    return buildItemPeopleWidget();
                  } else {
                    return buildBottomWidget();
                  }
                }),
          ),
          drawer: new Drawer(
            child: HomeBuilder.homeDrawer(context, (flag) {
              LogUtil.v(" drawer click " + flag.toString());
              _scaffoldKey.currentState.openEndDrawer();
              if (flag <= 4) {
                EventMessage.getDefault().post(flag);
              }
            }),
          ),
        ));
  }

  Widget buildItemHeader(String title, int flag) {
    return HeaderItem(
        leftIcon: Icons.book,
        title: title,
        onTap: () {
          LogUtil.e("推荐项目: 更多");
          if (flag == 1) {
            RouteUtil.pushCoursListPage(context, title);
          }
        });
  }

  //推荐阅读 Item
  Widget buildItemReadWidget() {
    List<Widget> children = mReposModelList.map((model) {
      return new ReposItem(
        model,
        true,
      );
    }).toList();
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  //推荐达人 Item
  Widget buildItemPeopleWidget() {
    List<Widget> children = mArticleModelList.map((model) {
      return new ArticleItem(
        model,
        true,
      );
    }).toList();
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
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

  void loadingDatas() {
    homeManager.getBanner((List<BannerModel> list) {
      mBannerModelList = list;
      setState(() {});
    });
    homeManager.getCourse((int code, List<CourseBean> list) {
      mReposModelList = list;
      setState(() {});
    });

    homeManager.getUserList((int code, List<UserModel> list) {
      mArticleModelList = list;
      setState(() {});
    });
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.only(bottom: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text("${++index}/$itemCount",
          style: TextStyle(color: Colors.white70, fontSize: 11.0)),
    );
  }
}
