import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

/**
 * SlideTransition 平移动画
 */
class SlideTransitionPage extends StatefulWidget {
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
        //将动画重置到开始前的状态
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
        controller.forward();
      } else if (status == AnimationStatus.forward) {
        print("status is forward");
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
        print("status is reverse");
      }
    });
    //begin: Offset.zero, end: Offset(1, 0) 以左下角为参考点，相对于左下角坐标 x轴方向向右 平移执行动画的view 的1倍 宽度，
    // y轴方向不动，也就是水平向右平移

    //begin: Offset.zero, end: Offset(1, 1) 以左下角为参考点，相对于左下角坐标 x轴方向向右 平移执行动画的view 的1倍 宽度，
    // y轴方向 向下 平衡执行动画view 的1倍的高度，也就是向右下角平移了

    //begin: Offset(1, 0), end: Offset(1, 1) 在构建布局页面的时候，执行动画的view 会先相对于自身左下角水平向右移动 执行动画的view 的1倍 宽度，
    //动画开始后 再次 移动到 end: Offset(1, 1)
    animation =
        Tween(begin: Offset(0, 0), end: Offset(0, 1)).animate(controller);

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

  //平移
  Widget buildSlideTransition() {
    return Center(
      child: SlideTransition(
        position: animation,
        //将要执行动画的子view
        child: Container(
          width: 200,
          height: 200,
          color: Colors.grey,
        ),
      ),
    );
  }

  //旋转
  Widget buildRotationTransition() {
    return Center(
      child: RotationTransition(
        //设置动画的旋转中心
        alignment: Alignment.center,
        //动画控制器
        turns: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
        ),
      ),
    );
  }
}
