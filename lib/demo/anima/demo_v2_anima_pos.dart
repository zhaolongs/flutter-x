import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

/**
 * RelativeRectTween 缩放动画
 */
class RelativeRectTweenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RelativeRectTweenState();
  }
}

class RelativeRectTweenState extends BaseAppBarPageState<StatefulWidget>
    with SingleTickerProviderStateMixin {
  //动画控制器
  AnimationController controller;
  Animation<RelativeRect> animation;

  @override
  String buildInitState() {
    buildBackBar("动画", backIcon: Icons.arrow_back_ios);
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        print("status is completed");
        //反向执行
        //controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
        //controller.forward();
      } else if (status == AnimationStatus.forward) {
        print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        print("status is reverse");
      }
    });

    RelativeRectTween rectTween = RelativeRectTween(
      //初始位置设置
      begin: const RelativeRect.fromLTRB(
          50.0,
          50.0,
          50.0,
          50.0),
      //结束位置设置
      end: RelativeRect.fromLTRB(
        200.0,
        50.0,
        50.0,
        50.0,
      ),
    );

    //关联 controller
    animation = rectTween.animate(controller);

    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return buildSlideTransition();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //渐变动画
  Widget buildSlideTransition() {
    return Stack(
      children: <Widget>[
        //必须作为Stack的子widget
        PositionedTransition(
          rect: animation,
          child: Container(
            color: Colors.grey,
            child: Image.network(
              "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: FlatButton(
              onPressed: () {
                if (controller.isDismissed) {
                  ///正向动画开始
                  controller.forward();
                } else if (controller.isCompleted) {
                  ///反向动画开始
                  controller.reverse();
                } else {
                  //停止
                  controller.dispose();
                  //重置动画
                  controller.reset();
                }
              },
              child: Text("开始")),
        )
      ],
    );
  }
}
