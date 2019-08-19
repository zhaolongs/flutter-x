import 'package:flutter/material.dart';

///透明度变化:或隐或现的美女
class FTDemo extends StatefulWidget {
  @override
  _FTState createState() => _FTState();
}

class _FTState extends State<FTDemo> with SingleTickerProviderStateMixin {
  AnimationController controller; //动画控制器
  @override
  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    ///动画开始
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("FadeTransition简单使用")),
          elevation: 0.0,
        ),
        body: Center(
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: FadeTransition(

              opacity: controller,
              child: Image.network(
                "http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg",
              ),
            ),
          ),
        ));
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
