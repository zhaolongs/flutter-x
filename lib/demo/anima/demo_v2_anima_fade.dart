import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

/**
 * FadeTransition 渐变动画
 */
class FadeTransitionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AnimaScalePageState();
  }
}

class AnimaScalePageState extends BaseAppBarPageState<StatefulWidget>
    with SingleTickerProviderStateMixin {
  //动画控制器
  AnimationController controller;
  Animation<Offset> animation;

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

    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: FlatButton(
                  onPressed: () {
                    ///动画开始
                    controller.forward();
                  },
                  child: Text("开始")),
            ),
            buildSlideTransition(),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //渐变动画
  Widget buildSlideTransition() {
    return Center(
      child: FadeTransition(
        opacity: controller,
        //将要执行动画的子view
        child: Container(
          width: 200,
          height: 200,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }
}
