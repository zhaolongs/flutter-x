import 'package:flutter/material.dart';
///点击图片使得两个图片来回切换
///https://docs.flutter.io/flutter/widgets/AnimatedCrossFade-class.html
class AnimatedCrossFadeDemo extends StatefulWidget {
  @override
  _ACFState createState() => _ACFState();
}

class _ACFState extends State<AnimatedCrossFadeDemo> {
  bool isFirst=true;
  _ACFState();

  @override
  Widget build(BuildContext context) {
    String tip = "点击图片切换";
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("AnimatedCrossFade简单使用")),
          elevation: 0.0,
        ),
        body: Center(
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {//点击改变状态
                  isFirst =!isFirst;
                });
              },
              child: Center(
                  child:Column(
                    children: <Widget>[
                      Text(tip),
                      AnimatedCrossFade(
                        crossFadeState: isFirst?CrossFadeState.showFirst:CrossFadeState.showSecond,
                        firstChild: Image.network("http://img5.duitang.com/uploads/item/201411/16/20141116124947_xBNxM.jpeg"),
                        secondChild: Image.network("http://pic13.nipic.com/20110425/668573_150157400119_2.jpg"),
                        duration: Duration(milliseconds: 500),
                      ),
                    ],
                  )
              ),
            ),
          ),
        ));
  }
}