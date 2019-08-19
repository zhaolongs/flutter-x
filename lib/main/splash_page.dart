import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

/**
 * 引导页面
 */
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends BasePage {
  TimerUtil _timerUtil;
  String imageUrl =
      "http://b-ssl.duitang.com/uploads/item/201311/02/20131102150044_YGB5u.jpeg";

  //图片集合
  List<String> imageList = new List();
  //控件集合
  List<Widget> bannerViewList = new List();
  int indeflag = 0;

  @override
  void initState() {
    super.initState();
    //初始化图片数据
    for (int i = 0; i < 4; i++) {
      imageList.add(imageUrl);
    }
    _initBannerData();
  }


  /**
   * Stack即层叠布局控件，能够将子控件层叠排列,与Android中的Frame布局是相似的，子widget可以根据到父容器四个角的位置来确定本身的位置
   *
   */
  void _initBannerData() {
    for (int i = 0, length = imageList.length; i < length; i++) {
      if (i == length - 1) {
        bannerViewList.add(new Stack(
          //Stack即层叠布局控件，能够将子控件层叠排列
          //alignment：此参数决定如何去对齐没有定位（没有使用Positioned）或部分定位的子widget。所谓部分定位，在这里特指没有在某一个轴上定位：left、right为横轴，top、bottom为纵轴，只要包含某个轴上的一个定位属性就算在该轴上有定位。
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            new CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              imageUrl: imageUrl,
              placeholder: (context, url) => buildProgressView(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 80.0),
                child: buildFlatButton(
                    "立即体验",
                    () => {
                          RouteUtil.goMain(context),
                        }),
              ),
            ),
          ],
        ));
      } else {
        bannerViewList.add(
          new CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: imageUrl,
            placeholder: (context, url) => buildProgressView(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        );
      }
    }
  }

  void goMain() {
    RouteUtil.goMain(context);
  }

  Widget _buildAdWidget() {
    return new Container(
      height: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var controller = SwiperController(initialPage: 1);

    return new Material(
      child: new Stack(
        children: <Widget>[
          new Swiper(
              //默认 Axis.horizontal水平滚动
              direction: Axis.horizontal,
              //自动轮播 开关
              autoStart: false,
              //自动轮播间隔时间
              speed: 300,
              //轮播到最后一张与开始第一张的切换模式
              circular: false,
              //指示器
              indicator: CircleSwiperIndicator(
                radius: 4.0,
                padding: EdgeInsets.only(bottom: 30.0),
                // 指示器颜色
                itemColor: Colors.black26,
              ),
              //控制器
              controller: controller,
              //子View
              children: bannerViewList),
          _buildAdWidget(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得中dispose里面把timer cancel。
  }
}
