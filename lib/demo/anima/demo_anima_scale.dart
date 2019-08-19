import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';


/**
 * 缩放动画
 */
class AnimaScalePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AnimaScalePageState();
  }
}

class AnimaScalePageState extends BaseAppBarPageState<StatefulWidget>
    with SingleTickerProviderStateMixin {

  //动画实例
  Animation<double> animation;
  //动画控制器
  AnimationController controller;
  
  @override
  String buildInitState() {
    buildBackBar("缩放动画", backIcon: Icons.arrow_back_ios);

    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //AnimationStatus.completed 动画在结束时停止的状态
        //ontroller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //AnimationStatus.dismissed 表示动画在开始时就停止的状态
        //controller.forward();
      }
    });
    //写法1、图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() => {});
      });

    //写法 2  宽高变化倍率从 0-1，然后图片的实际宽高使用 指定宽高来与倍率相乘

    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
        ),
        FlatButton(
          onPressed: () {
            controller.forward();
          },
          child: Text(
            "动画 放大",
            style: TextStyle(color: Colors.red),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
        ),
        FlatButton(
          onPressed: () {
            controller.reverse();
          },
          child: Text(
            "动画 缩小",
            style: TextStyle(color: Colors.red),
          ),
        ),
        Container(
          color: Colors.grey,
          height: 300,
          child: new Center(
            child: Image.network(
                "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
                width: animation.value,
                height: animation.value),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
