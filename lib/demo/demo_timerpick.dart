import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/common/common_colors.dart';

class TimerPickPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerPickPageState();
  }
}

class TimerPickPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("TimerPickPage", backIcon: Icons.arrow_back_ios);
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
        ),
        //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
        buildWhiteFlatButton("ios 风格 时间选择器", () {
          showCupertinoTimerPicker(context);
        }),
        buildWhiteFlatButton("ios 风格 日期选择器", () {
          showCupertinoDatePicker(context);
        }),
        buildWhiteFlatButton("日期选择 ", () {
          showDefaultYearPicker(context);
        }),
        buildWhiteFlatButton("时间选择 ", () {
          showDefaultDatePicker(context);
        }),
        buildWhiteFlatButton("24 小时时间选择 ", () {
          show24DatePicker(context);
        }),
      ],
    );
  }

  void showCupertinoTimerPicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          Widget picker = buildTimePicker();
          return CupertinoTheme(child: buildBottomPicker(picker),data: CommonColors.cupertinoThemeData,);
        });
  }

  void showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          Widget picker = buildDatePicker();
          return buildBottomPicker(picker);
        });
  }

  Widget buildTimePicker() {
    //设置初始显示时间信息
    Duration timer = Duration(hours: 2, minutes: 20, seconds: 10);
    CupertinoTimerPicker cupertinoTimerPicker = new CupertinoTimerPicker(
      onTimerDurationChanged: (Duration newTimer) {
        print(" select " + newTimer.toString());
      },
      //设置初始显示时间信息
      initialTimerDuration: timer,
      //显示 时 分 秒
      mode: CupertinoTimerPickerMode.hms,
      //设置分钟变化间隔为 1分钟
      minuteInterval: 1,
      //设置秒变化间隔为 1分钟
      secondInterval: 1,
    );
    return cupertinoTimerPicker;
  }

  Widget buildDatePicker() {
    //设置初始显示时间信息
    Duration timer = Duration(hours: 2, minutes: 20, seconds: 10);
    CupertinoDatePicker cupertinoTimerPicker = new CupertinoDatePicker(
      onDateTimeChanged: (DateTime newTimer) {
        print(" select " + newTimer.toString());
      },
      //只显示 日期  CupertinoDatePickerMode.date
      //只显示 时间  CupertinoDatePickerMode.time
      //日期 时间都显示 CupertinoDatePickerMode.dateAndTime
      mode: CupertinoDatePickerMode.dateAndTime,
      //设置初始显示时间信息
      initialDateTime: DateTime.now(),
      //显示 时 分 秒
      minimumYear: 2019,
    );
    return cupertinoTimerPicker;
  }

  Widget buildCityPicker() {
    //设置初始显示时间信息
    Duration timer = Duration(hours: 2, minutes: 20, seconds: 10);
    CupertinoDatePicker cupertinoTimerPicker = new CupertinoDatePicker(
      onDateTimeChanged: (DateTime newTimer) {
        print(" select " + newTimer.toString());
      },
      mode: CupertinoDatePickerMode.date,
      //设置初始显示时间信息
      initialDateTime: DateTime.now(),
      //显示 时 分 秒
      minimumYear: 2019,
    );
    return cupertinoTimerPicker;
  }

  Widget buildBottomPicker(Widget picker) {
    Container container = new Container(
      height: 260,
      padding: EdgeInsets.only(top: 10),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
          style: TextStyle(color: CupertinoColors.black, fontSize: 22.0),
          child: GestureDetector(
            onTap: () {},
            child: SafeArea(
              child: picker,
              top: false,
            ),
          )),
    );
    return container;
  }

  //设置默认显示的日期为当前
  DateTime initialDate = DateTime.now();

  void showDefaultYearPicker(BuildContext context) async {
    final DateTime dateTime = await showDatePicker(
      context: context,
      //定义控件打开时默认选择日期
      initialDate: initialDate,
      //定义控件最早可以选择的日期
      firstDate: DateTime(2018, 1),
      //定义控件最晚可以选择的日期
      lastDate: DateTime(2022, 1),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: CommonColors.themData,
          child: child,
        );
      },
    );
    if (dateTime != null && dateTime != initialDate) {}
  }

  //设置显示显示的时间为当前
  TimeOfDay initialTime = TimeOfDay.now();
  void showDefaultDatePicker(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: CommonColors.themData,
          child: child,
        );
      },
    );
    if (timeOfDay != null && timeOfDay != initialTime) {
      setState(() {
        initialTime = timeOfDay;
      });
    }
  }

  void show24DatePicker(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: CommonColors.themData,
          child: child,
        );
      },
    );
    if (timeOfDay != null && timeOfDay != initialTime) {
      setState(() {
        initialTime = timeOfDay;
      });
    }
  }
}
