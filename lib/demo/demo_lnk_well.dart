import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class InkWellPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InkWellState();
  }
}

class InkWellState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("InkWell", backIcon: Icons.arrow_back_ios);
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return buildItem();
  }

  Widget buildItem() {
    return new Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(20),),
        new Center(
          child: new Material(
            // 设置背景颜色
            color: Colors.purple,
            child: new InkWell(
              //点击事件回调
              onTap: () {},
              //不要在这里设置背景色，for则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
              child: new Container(
                width: 300.0,
                height: 50.0,
                //设置child 居中
                alignment: Alignment(0, 0),
                child: Text("登录",style: TextStyle(color: Colors.white,fontSize: 16.0),),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(20),),
        new Center(
          child: new Material(
            //INK可以实现装饰容器，实现矩形  设置背景色
            child: new Ink(
              //设置背景 矩形
              color: Colors.purple,
              child: new InkWell(
                //点击事件回调
                onTap: () {},
                child: new Container(
                  width: 300.0,
                  height: 50.0,
                  //设置child 居中
                  alignment: Alignment(0, 0),
                  child: Text("登录",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(20),),
        new Center(
          child: new Material(
            //INK可以实现装饰容器
            child: new Ink(
              //用ink圆角矩形
            // color: Colors.red,
              decoration: new BoxDecoration(
               //不能同时”使用Ink的变量color属性以及decoration属性，两个只能存在一个
                color: Colors.purple,
                //设置圆角
                borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
              ),
              child: new InkWell(
                //圆角设置,给水波纹也设置同样的圆角
                //如果这里不设置就会出现矩形的水波纹效果
                borderRadius: new BorderRadius.circular(25.0), 
                //设置点击事件回调
                onTap: () {

                },
                child: new Container(
                  width: 300.0,
                  height: 50.0,
                  //设置child 居中
                  alignment: Alignment(0, 0),
                  child: Text("登录",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                ),
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(20),),
        new Center(
          child: new Material(
            child: new Ink(
              //设置背景
              decoration: new BoxDecoration(
                color: Colors.purple,
                borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
              ),
              child: new InkResponse(
                borderRadius: new BorderRadius.all(new Radius.circular(25.0)),
                //点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
                //highlightColor: Colors.yellowAccent,
                //点击或者toch控件高亮的shape形状
                highlightShape: BoxShape.rectangle,
                //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
                //水波纹的半径
                radius: 300.0,
                //水波纹的颜色
                splashColor: Colors.black,
                //true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
                containedInkWell: true,
                //点击事件
                onTap: () {
                  print("click");
                },
                child: new Container(
                  //不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
                  width: 300.0,
                  height: 50.0,
                  //设置child 居中
                  alignment: Alignment(0, 0),
                  child: Text("登录",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                ),

              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(20),),
        new Center(
          child: new Material(
            child: new Ink(
              //设置背景
              decoration: new BoxDecoration(
                color: Colors.purple,
                borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
              ),
              child: new InkResponse(
                borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                //点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
                highlightColor: Colors.purple[800],
                //点击或者toch控件高亮的shape形状
                highlightShape: BoxShape.rectangle,
                //.InkResponse内部的radius这个需要注意的是，我们需要半径大于控件的宽，如果radius过小，显示的水波纹就是一个很小的圆，
                //水波纹的半径
                radius: 0.0,
                //水波纹的颜色 设置了highlightColor属性后 splashColor将不起效果
                splashColor: Colors.red,
                //true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
                containedInkWell: true,

                onTap: () {
                  print(
                      'click');
                },
                child: new Container(
                  //不能在InkResponse的child容器内部设置装饰器颜色，否则会遮盖住水波纹颜色的，containedInkWell设置为false就能看到是否是遮盖了。
                  width: 300.0,
                  height: 50.0,
                  //设置child 居中
                  alignment: Alignment(0, 0),
                  child: Text("登录",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
