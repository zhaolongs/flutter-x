

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WelcomePageState();
  }
}

class WelcomePageState extends BasePage {
  TimerUtil _timerUtil;

  String imageUrl ="http://attachments.gfan.net.cn/forum/201501/22/2246523mw488648yfcmvxx.jpg";
  int _status = 0;
  int _count = 3;
  var isSplash = false;

  @override
  void initState() {
    super.initState();
    initTimerFunction();
  }

  void initTimerFunction() {
    setState(() {
      _status = 1;
    });
    //计时4秒
    int totalTime = 4* 1000;
    // 初始化设置
    _timerUtil = new TimerUtil(mTotalTime: totalTime);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
        LogUtil.v(" count is  "+_count.toString());
      });
      if (_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }

  void _goMain() {
    RouteUtil.goMain(context);
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: imageUrl,
            placeholder: (context, url) => buildProgressView(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          new Offstage(
            offstage: !(_status == 1),
            child: new Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _timerUtil.cancel();
                  _goMain();
                },
                child: new Container(
                    padding: EdgeInsets.all(12.0),
                    child: new Text(
                      '跳过 $_count',
                      style: new TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    decoration: new BoxDecoration(
                        color: Color(0x66000000),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        border: new Border.all(
                            width: 0.33, color: CommonColors.divider))),
              ),
            ),
          )
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
