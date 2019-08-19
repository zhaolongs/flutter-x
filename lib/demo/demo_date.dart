import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class DataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DataPageState();
  }
}

class DataPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("时间格式化", backIcon: Icons.arrow_back_ios);

    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    //获取当前时间的毫秒数
    int nowDateMilliseconds = DateUtil.getNowDateMs();
    print("nowDateMilliseconds: "+nowDateMilliseconds.toString());

    //获取当前时间
    String nowDateStr = DateUtil.getNowDateStr();
    print("nowDateStr: "+nowDateStr.toString());

    //获取指定时间对应的周
    String zhWeekDayByMs = DateUtil.getZHWeekDayByMs(1562484092000);
    print("zhWeekDayByMs: "+zhWeekDayByMs.toString());

    //将日期转为 毫秒
    int dateMsByTimeStr = DateUtil.getDateMsByTimeStr("2019-07-07 15:21:32");
    print("dateMsByTimeStr: "+dateMsByTimeStr.toString());

    //将毫秒转为 日期格式
    String dateStrByMs = DateUtil.getDateStrByMs(1562484092000);
    print("dateStrByMs: "+dateStrByMs.toString());
    //将毫秒转为 日期格式 指定日期格式
    var dateStrByMs2 = DateUtil.getDateStrByMs(1562484092000,format: DateFormat.HOUR_MINUTE);
    print("dateStrByMs2: "+dateStrByMs2.toString());

    //指定日期时间
    var format5 = TimelineUtil.format(1562485553000);
    var format2 = TimelineUtil.format(1562484092000);
    var format4 = TimelineUtil.format(1562466092000);
    var format3 = TimelineUtil.format(1562311292000);

    print("format "+format5);
    print("format "+format2);
    print("format "+format4);
    print("format "+format3);
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("当前时间 " + nowDateMilliseconds.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("当前时间 " + nowDateStr),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("当前时间 " + zhWeekDayByMs),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("将日期转为 毫秒 " + dateMsByTimeStr.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("将毫秒转为 日期格式 " + dateStrByMs.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("时间处理 " + format5.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("时间处理 " + format2.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("时间处理 " + format4.toString()),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text("时间处理 " + format3.toString()),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
