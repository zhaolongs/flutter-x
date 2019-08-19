import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/common/user_helper.dart';
import 'package:flutter_x/utils/route_utils.dart';

import 'package:flutter_x/view/product_item.dart';

/**
 * 我的页面
 */
class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyPageState();
  }
}

class MyPageState extends BasePage<MyPage> {
  String imageUrl =
      "http://pic31.nipic.com/20130711/8952533_164845225000_2.jpg";

  Widget _buildItem(BuildContext context, MyPageItem product) {
    return Column(
      children: <Widget>[
        Container(
          height: 43.0,
          padding: const EdgeInsets.only(left: 12.0, right: 0.0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 21.0,
                height: 21.0,
                child: Image.asset(
                  product.asset,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.left,
                ),
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
        Container(
          color: CommonColors.divider,
          height: 1.0,
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            //右侧的内容和点击事件啥的
            actions: <Widget>[
              // _buildAction(),
            ],
            //左侧的按钮的动作
            leading: GestureDetector(
              child: Icon(Icons.person),
              onTap: () => LogUtil.v("on tap"),
            ),
            //左侧按钮
            /**
             * 如果没有leading，automaticallyImplyLeading为true，就会默认返回箭头
             * 如果 没有leading 且为false，空间留给title
             * 如果有leading，这个参数就无效了
             */
            automaticallyImplyLeading: false,
            //标题是否居中
            centerTitle: true,
            //阴影的高度
            elevation: 4,
            //是否显示阴影
            forceElevated: false,
            // 状态栏的亮度  黑底白字，lignt 白底黑字
            // 默认是和 ThemeData.primaryColorBrightness 一致的.
            brightness: Brightness.dark,
            //可以是文字或者widget
            title: Text(''),
            //导航栏和状态栏的的颜色
            backgroundColor: CommonColors.base_red,
            //所有的icon的样式,不仅仅是左侧的，右侧的也会改变
            iconTheme: IconThemeData(color: Colors.white, size: 30, opacity: 1),
            //展开高度  默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
            expandedHeight: 200.0,
            //字体样式
            textTheme: TextTheme(),
            // appbar是否显示在屏幕的最上面，为false是显示在最上面，为true就显示在状态栏的下面
            primary: true,
            //标题两边的空白区域
            titleSpacing: 16,
            //是否随着滑动隐藏标题 滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
            floating: false,
            //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
            snap: false,
            //是否固定在顶部
            pinned: true,
            //可折叠的应用栏
            flexibleSpace: buildFlexiWidget(context),
          ),
          SliverFixedExtentList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              MyPageItem product = products[index];
              return GestureDetector(
                child: _buildItem(context, product),
                onTap: () => LogUtil.v("on tap $index " + product.name),
              );
            }, childCount: products.length),
            //条目的高度
            itemExtent: 44.0,
          )
        ],
      ),
    );
  }

  buildFlexiWidget(BuildContext context) {
    var login = UserHelper.getInstance().isLogin();
    var headerWidget;
    if (login) {
    } else {
      headerWidget = buildWhiteFlatButton("登录", (){
        RouteUtil.goLogin(context);
      });
    }

    return new Stack(
      children: <Widget>[
        FlexibleSpaceBar(
          background: ConstrainedBox(
            child: Image.asset(
              "images/bg_person_header.png",
              fit: BoxFit.fill,
            ),
            constraints: new BoxConstraints.expand(),
          ),
        ),
        Center(child: headerWidget,)
      ],
    );
  }
}
