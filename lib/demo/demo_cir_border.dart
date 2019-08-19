import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class CirBorderContainerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DialogPageState();
  }
}

class DialogPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("圆角边框", backIcon: Icons.arrow_back_ios);
    return null;
  }

  int _count = 0;

  @override
  Widget buildWidget(BuildContext context) {
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, top: 40),
          //设置 child 居中
          alignment: Alignment(0, 0),
          height: 50,
          width: 300,
          //边框设置
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            //设置四周边框
            border: new Border.all(width: 1, color: Colors.red),
          ),
          child: Text("Container 的圆角边框"),
        ),
        //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
        Container(
          margin: EdgeInsets.only(left: 40, top: 40),
          //设置 child 居中
          alignment: Alignment(0, 0),
          height: 50,
          width: 300,
          //边框设置
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            //设置四周边框
            border: new Border.all(width: 1, color: Colors.red),
          ),
          child: Text("Container 的圆角边框"),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, top: 40),
          child: new Material(
            //INK可以实现装饰容器
            child: new Ink(
              //用ink圆角矩形
              // color: Colors.red,
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: Colors.red),
              ),
              child: new InkWell(
                  //圆角设置,给水波纹也设置同样的圆角
                  //如果这里不设置就会出现矩形的水波纹效果
                  borderRadius: new BorderRadius.circular(25.0),
                  //设置点击事件回调
                  onTap: () {},
                  child: Container(
                    //设置 child 居中
                    alignment: Alignment(0, 0),
                    height: 50,
                    width: 300,
                    child: Text("点击 Container 圆角边框"),
                  )),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 40, top: 40),
          child: new Material(
            child: new Ink(
              //设置背景
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: Colors.red),
              ),
              child: new InkResponse(
                borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
                //点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
//                highlightColor: Colors.deepPurple,
                //点击或者toch控件高亮的shape形状
                highlightShape: BoxShape.rectangle,
                //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
                //水波纹的半径
                radius: 300.0,
                //水波纹的颜色
                splashColor: Colors.yellow,
                //true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
                containedInkWell: true,
                //点击事件
                onTap: () {
                  print("click");
                },
                child: Container(
                  //设置 child 居中
                  alignment: Alignment(0, 0),
                  height: 50,
                  width: 300,
                  child: Text("点击 Container 圆角边框"),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
        ),
      ],
    );
  }
}
