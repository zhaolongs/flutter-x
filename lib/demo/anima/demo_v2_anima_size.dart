import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

/**
 * SizeTransition 旋转动画
 */
class SizeTransitionPage extends StatefulWidget {
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
    buildBackBar("动画", backIcon: Icons.arrow_back_ios);
    //AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，
    // 默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字
    //用来控制动画的开始与结束以及设置动画的监听
    //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        print("status is completed");
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
        print("status is dismissed");
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
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: 1.0,动画内容从左向右拉出")),
              buildRotationTransition(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: -1.0,动画内容从右向左拉出")),
              buildRotationTransition2(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: 0.0,动画从中间向左右两边拉出")),
              buildRotationTransition3(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: 1.0,动画内容从左向右拉出")),
              buildRotationTransition4(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: -1.0,动画内容从右向左拉出")),
              buildRotationTransition5(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: 0.0,动画从中间向左右两边拉出")),
              buildRotationTransition6(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: 0.0,动画从中间向左右两边拉出")),
              buildRotationTransition7(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: 0.0,动画从中间向左右两边拉出")),
              buildRotationTransition8(),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "axis: Axis.horizontal,axisAlignment: 0.0,动画从中间向左右两边拉出")),
              buildRotationTransition9(),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FlatButton(
                onPressed: () {
                  if (controller.isCompleted) {
                    controller.reverse();
                  } else {
                    ///动画开始
                    controller.forward();
                  }
                },
                child: Text("开始")),
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

  /**
   * axis: Axis.horizontal,axisAlignment: -1.0, 动画内容从右向左拉出  也就是最左边的内容先出来
   * axis: Axis.horizontal,axisAlignment: 0.0,  动画从中间向左右两边拉出
   * axis: Axis.horizontal,axisAlignment: 1.0,  动画内容从左向右拉出 也就是最右边的的内容先出来
   */
  //Size
  Widget buildRotationTransition() {
    return Container(
      alignment: Alignment(-1, -1),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: 1.0,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }

  Widget buildRotationTransition2() {
    return Container(
      alignment: Alignment(-1, -1),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: -1.0,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }

  Widget buildRotationTransition3() {
    return Container(
      alignment: Alignment(-1, -1),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: 0.0,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }

  Widget buildRotationTransition4() {
    return Container(
      alignment: Alignment(0, 0),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: -1.0,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }

  Widget buildRotationTransition5() {
    return Container(
      alignment: Alignment(0, 0),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: 0.0,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }

  Widget buildRotationTransition6() {
    return Container(
      alignment: Alignment(0, 0),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: 1,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }
  Widget buildRotationTransition7() {
    return Container(
      alignment: Alignment(1, 0),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: -1,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }
  Widget buildRotationTransition8() {
    return Container(
      alignment: Alignment(1, 0),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: 0,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }
  Widget buildRotationTransition9() {
    return Container(
      alignment: Alignment(1, 0),
      child: SizeTransition(
        //动画在水平方向执行
        axis: Axis.horizontal,
        axisAlignment: 1,
        //动画控制器
        sizeFactor: controller,
        //将要执行动画的子view
        child: Container(
          width: 100,
          height: 100,
          color: Colors.grey,
          child: Image.network(
            "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
          ),
        ),
      ),
    );
  }
}
