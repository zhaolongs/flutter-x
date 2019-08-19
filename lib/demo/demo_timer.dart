import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/utils/common_timerutil.dart';
import 'package:flutter_x/utils/route_utils.dart';

class TimerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerPageState();
  }
}

class TimerPageState extends BaseAppBarPageState<StatefulWidget> {

  String tiemn='';
  String tiemt ='';

  TimerUtil _timerUtil;
  TimerUtil _commonTimerUtil;
  @override
  String buildInitState() {
    buildBackBar("计时器", backIcon: Icons.arrow_back_ios);

    //计时4秒
    int totalTime = 4* 1000;
    // 初始化设置
    _timerUtil = new TimerUtil(mTotalTime: totalTime);
    //设置计时回调
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        tiemn = _tick.toString();
      });
    });
    //开始倒计时
    _timerUtil.startCountDown();


    //初始化开始时间
    int stratTime = 1000;
    // 初始化设置
    _commonTimerUtil = new TimerUtil();
    //设置计时回调
    _commonTimerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        tiemt = _tick.toString();
      });
    });
    //开始倒计时
    _commonTimerUtil.startTimer();


    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
        ),

        Padding(
          padding: EdgeInsets.all(10),
          child: Text("倒计时 "+tiemn),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("正计时 "+tiemt),
        ),
      ],
    );
  }

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commonTimerUtil.cancel();
    _timerUtil.cancel();
  }
}
