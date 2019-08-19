import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/dialog/commondialog.dart';
import 'package:flutter_x/utils/image_util.dart';

class DialogPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DialogPageState();
  }
}

class DialogPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("dialog", backIcon: Icons.arrow_back_ios);
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
        buildWhiteFlatButton("CupertinoDialogAction", () {
          showCupertinoAlertDialog();
        }),
        buildWhiteFlatButton("AlertDialog", () {
          showAlertDialog();
        }),
        buildWhiteFlatButton("SimpleDialog", () {
          showSimpleDialog();
        }),

        buildWhiteFlatButton("可编辑操作", () {
          showPariseDialog();
        }),
      ],
    );
  }

  void showCupertinoAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("这是一个iOS风格的对话框"),
            content: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Align(
                  child: Text("这是消息"),
                  alignment: Alignment(0, 0),
                ),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context);
                  print("取消");
                },
              ),
              CupertinoDialogAction(
                child: Text("确定"),
                onPressed: () {
                  print("确定");
                },
              ),
            ],
          );
        });
  }

  void showAlertDialog() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('标题'),
            //可滑动
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text('内容 1'),
                  new Text('内容 2'),
                  new Text('内容 1'),
                  new Text('内容 2'),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('取消'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void showSimpleDialog() {
    showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('选择'),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('选项 1'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new SimpleDialogOption(
              child: new Text('选项 2'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //是否满意标识位记录
  int pariseSelectIndex = 0;
  //不满意原因标识位记录
  int pariseSelectIndex2 = 0;
  void showPariseDialog() {
    showDialog<Null>(
        context: context,
        //点击背景不消失
        barrierDismissible: false,
        builder: (context) {
          //StatefulBuilder 来构建 dialog
          //使用参数 state来更新 dialog 中的数据内容
          return StatefulBuilder(builder: (context, state) {
            //创建dialog
            return new CommonDialog(
              title: "服务完成给个好平吧!",
              negativeText: "取消",
              positiveText: "确认",
              isShowTitleDivi: false,
              onPositivePressEvent: () {
                print("确认 关闭");
                Navigator.pop(context);
              },
              onCloseEvent: () {
                print("取消 关闭");
                Navigator.pop(context);
              },
              //通过state来刷新内容
              childWidget: buildPariseChildDialog(state),
            );
          });
        });
  }

  Widget buildPariseChildDialog(state){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          //填充
          mainAxisSize: MainAxisSize.max,
          //平分空白
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildPariseChildWidget(
                0, "非常满意", pariseSelectIndex == 0 ? true : false,state),
            buildPariseChildWidget(
                1, "满意", pariseSelectIndex == 1 ? true : false,state),
            buildPariseChildWidget(
                2, "不满意", pariseSelectIndex == 2 ? true : false,state),
          ],
        ),
        pariseSelectIndex==2?gridViewDefaultCount(state):Container(),
      ],
    );
  }

  //分析文章在这里 https://blog.csdn.net/zl18603543572/article/details/95037826
  Widget buildPariseChildWidget(int index, String message, bool select,state) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        //设置 child 居中
        alignment: Alignment(0, 0),
        height: 30,
        child: new Center(
          child: new Material(
            child: new Ink(
              key: ValueKey(index),
              //设置背景
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                //设置四周边框
                border: new Border.all(
                    width: 1, color: select ? Colors.red : Colors.grey),
              ),
              child: new InkResponse(
                borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
                //点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
                highlightColor: Color(0xfffbfbfb),
                //点击或者toch控件高亮的shape形状
                highlightShape: BoxShape.rectangle,
                //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
                //水波纹的半径
                radius: 0.0,
                //水波纹的颜色 设置了highlightColor属性后 splashColor将不起效果
                splashColor: Color(0xfffbfbfb),
                //true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
                containedInkWell: true,

                onTap: () {
                  pariseSelectIndex = index;
                  print('click ' + pariseSelectIndex.toString());
                  state(() {});
                },
                child: new Container(
                  //不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
                  width: 300.0,
                  height: 50.0,
                  //设置child 居中
                  alignment: Alignment(0, 0),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: select ? Colors.red : Colors.grey,
                        fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget gridViewDefaultCount(state) {
    int count = 3;
    double height = 60;

    return Container(
      margin: EdgeInsets.only(top: 20),
      //设置 child 居中
      alignment: Alignment(0, 0),
      height: height,
      //边框设置
      decoration: new BoxDecoration(
        //背景
        color: Color(0xfff6f6f6),
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        //设置四周边框
        border: new Border.all(width: 1, color: Color(0xfff6f6f6)),
      ),
      child: initListWidget(count,state),
    );
  }

  Widget initListWidget(int count,state) {
    List<Widget> lists = [];
    List<Widget> clists = [];

    lists.add(buildPariseSelectChildWidget(
        0, "出车慢", pariseSelectIndex2 == 0 ? true : false,state));
    lists.add(buildPariseSelectChildWidget(
        1, "服务差", pariseSelectIndex2 == 1 ? true : false,state));
    lists.add(buildPariseSelectChildWidget(
        2, "态度不好", pariseSelectIndex2 == 2 ? true : false,state));
    clists.add(Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: lists,
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: clists,
    );
  }

  Widget buildPariseSelectChildWidget(int index, String message, bool select,state) {
    return InkWell(
      //单击事件响应
      onTap: () {

        pariseSelectIndex2 = index;
        state(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            select
                ? ImageUtil.getImgsPath("phone_select_icon")
                : ImageUtil.getImgsPath("phone_noselect_icon"),
            width: 20.0,
            height: 20.0,
          ),
          Padding(
            child: Text(
              message,
              style: TextStyle(fontSize: 13, color: Color(0xff666666)),
            ),
            padding: EdgeInsets.only(left: 5.0),
          )
        ],
      ),
    );
  }
}
