import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class LeftPageViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LeftPageViewPageState();
  }
}

class LeftPageViewPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("pageView", backIcon: Icons.arrow_back_ios);
    return null;
  }

  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final List<Widget> _pages = <Widget>[
    new ConstrainedBox(
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
    ),
    new ConstrainedBox(
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
    ),
    new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: new Stack(
          //Stack即层叠布局控件，能够将子控件层叠排列
          //alignment：此参数决定如何去对齐没有定位（没有使用Positioned）或部分定位的子widget。所谓部分定位，在这里特指没有在某一个轴上定位：left、right为横轴，top、bottom为纵轴，只要包含某个轴上的一个定位属性就算在该轴上有定位。
          alignment: AlignmentDirectional.topStart,
          children: <Widget>[
            new CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              imageUrl:  "http://b-ssl.duitang.com/uploads/item/201311/02/20131102150044_YGB5u.jpeg",
              placeholder: (context, url) => SizedBox(width: 24,height: 25,child: CircularProgressIndicator(strokeWidth: 2.0,),),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 80.0),
                child: FlatButton(onPressed: (){}, child: Text("立即体验")) ,
              ),
            ),
          ],
        )),
  ];

  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement buildWidget
    return new Stack(
      children: <Widget>[
        //pageViw
        PageView.builder(
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index];
          },
          //条目个数
          itemCount: _pages.length,
        ),
        //圆点指示器
        new Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: new Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: new Center(
              child: new DotsIndicator(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageSelected: (int page) {
                    _controller.animateToPage(
                      page,
                      duration: _kDuration,
                      curve: _kCurve,
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.red,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
