import 'package:flutter/material.dart';

class AnimatedPaddingPage extends StatefulWidget {
  @override
  _APState createState() => _APState();
}

class _APState extends State<AnimatedPaddingPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("AnimatedPadding简单使用")),
          elevation: 0.0,
        ),
        body: Container(
          width: 500,
          height: 500,
          child: AnimatedPadding(
              duration: Duration(seconds: 4),
              padding: EdgeInsets.all(70),
              curve: Curves.linear,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              )),
        ));
  }
}
