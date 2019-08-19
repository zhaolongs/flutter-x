import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class BannerPageViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BannerPageViewPageState();
  }
}

const timeout = const Duration(seconds: 2);

class BannerPageViewPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("pageView", backIcon: Icons.arrow_back_ios);
    _pages = buildPageItemView();
    _controller = new PageController();
    _timer = Timer.periodic(timeout, _handleTimeout);
    return null;
  }
  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  PageController _controller;
  List<Widget> _pages;
  Timer _timer;
  int _index = 0;

  @override
  Widget buildWidget(BuildContext context) {
    Widget banner = Container(
      height: 200,
      child: new Stack(
        children: <Widget>[
          //pageViw
          PageView.builder(
            physics: new AlwaysScrollableScrollPhysics(),
            controller: _controller,
            onPageChanged: _onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),
          //圆点指示器

        ],
      ),
    );
    return banner;
  }

  _handleTimeout(Timer timer) {
    if (_pages.length - 2 != 0) {
      _index++;
      _controller.animateToPage(
        _index % (_pages.length - 2),
        duration: Duration(milliseconds: 16),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void _onPageChanged(int index) {
    _index = index;
    print("index "+index.toString());
    if (index == 0) {
      _controller.jumpToPage(_pages.length -1);
    } else if (index == _pages.length - 1) {
      _controller.jumpToPage(0);
    } else {

    }
  }

  buildPageItemView() {
    List<Widget> pages = new List();
    for (int i = 0; i < 6; i++) {
      Widget item = new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: new CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          imageUrl:
              "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=891407501,1385971678&fm=26&gp=0.jpg",
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
      pages.add(item);
    }
    return pages;
  }
}
