import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

/**
 * 缩放动画
 */
class ScaleTransDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AnimaScalePageState();
  }
}

class AnimaScalePageState extends BaseAppBarPageState<StatefulWidget>
    with SingleTickerProviderStateMixin {
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

    ///动画开始
    controller.forward();
    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: ScaleTransition(
          //设置动画的开始点
          alignment: Alignment.centerLeft,
          //动画控制器
          scale: controller,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
