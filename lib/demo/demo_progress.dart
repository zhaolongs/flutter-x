import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class PorgressViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PorgressViewPageState();
  }
}

class PorgressViewPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("progress", backIcon: Icons.arrow_back_ios);
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30),
          ),
          //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
          SizedBox(
            child: LinearProgressIndicator(),
            height: 8.0,
            width: 200,
          ),
          Padding(
            padding: EdgeInsets.all(30),
          ),
          SizedBox(
            child: CircularProgressIndicator(),
            height: 44.0,
            width: 44.0,
          ),
          Padding(
            padding: EdgeInsets.all(30),
          ),

          //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
          new SizedBox(
            height: 2.0,
            width: 200,
            child: new LinearProgressIndicator(),
          ),

          Padding(
            padding: EdgeInsets.all(30),
          ),

          //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
          new SizedBox(
            height: 2.0,
            width: 200,
            child: new LinearProgressIndicator(
              //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
              value: 0.3,
              //背景颜色
              backgroundColor: Colors.yellow,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
          ),

          //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
          new SizedBox(
            //限制进度条的高度
            height: 6.0,
            //限制进度条的宽度
            width: 200,
            child: new LinearProgressIndicator(
                //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                value: 0.3,
                //背景颜色
                backgroundColor: Colors.yellow,
                //进度颜色
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)),
          ),

          Padding(
            padding: EdgeInsets.all(30),
          ),

          //CircularProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
          new SizedBox(
            //限制进度条的高度
            height: 40.0,
            //限制进度条的宽度
            width: 40,
            child: new CircularProgressIndicator(
                //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                value: 0.3,
                //背景颜色
                backgroundColor: Colors.yellow,
                //进度颜色
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)),
          ),
          Padding(
            padding: EdgeInsets.all(30),
          ),

          //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
          new SizedBox(
            //限制进度条的高度
            height: 40.0,
            //限制进度条的宽度
            width: 40,
            child: new CircularProgressIndicator(
                //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                //value: 0.3,
                //背景颜色
                backgroundColor: Colors.yellow,
                //进度颜色
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)),
          ),
        ],
      ), ////滑动到底部回弹效果
      physics: BouncingScrollPhysics(),
    );
  }
}
