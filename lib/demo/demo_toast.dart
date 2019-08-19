import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/utils/route_utils.dart';
import 'package:flutter_x/utils/toast.dart';

class ToastPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DialogPageState();
  }
}

class DialogPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("Toast", backIcon: Icons.arrow_back_ios);
    return null;
  }

  int _count =0;
  @override
  Widget buildWidget(BuildContext context) {
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
        ),
        //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
        buildWhiteFlatButton("中间显示的 Toast", () {
          _count++;
          Toast.toast(context,msg: "中间显示的 Toast $_count",position: ToastPostion.center);
        }),
        buildWhiteFlatButton("顶部显示的 Toast", () {
          _count++;
          Toast.toast(context,msg: "顶部显示的 Toast $_count",position: ToastPostion.top);
        }),
        buildWhiteFlatButton("底部显示的 Toast ", () {
          _count++;
          Toast.toast(context,msg: "底部显示的 Toast $_count",position: ToastPostion.bottom);
        }),

      ],
    );
  }

}
