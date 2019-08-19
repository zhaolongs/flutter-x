import 'package:flutter/material.dart';

class GestureAppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _GestureAppPageState();
  }
}

class _GestureAppPageState extends State<GestureAppPage> {
  var tapEvent = '';
  var message = '';

  _showSnakeBar(String str) {
    final snackBar = new SnackBar(content: new Text(str));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Gesture'),
        centerTitle: true,
      ),
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(message),
          ),
          buildOnTab(),
          buildDoTab(),
          buildLongTab(),
          buildDownUp(),
          buildOnTabInWell(),
          buildOnTabInWell2(),
        ],
      ),
    );
  }

  Widget buildOnTab() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          print("单击事件 ");
          message = "单击事件 ";
          setState(() {});
        },
        child: Container(
          alignment: Alignment(0, 0),
          color: Colors.grey,
          height: 28,
          width: 120,
          child: Text("单击事件"),
        ),
      ),
    );
  }

  Widget buildDoTab() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onDoubleTap: () {
          print("双击事件 ");
          message = "双击事件 ";
          setState(() {});
        },
        child: Container(
          alignment: Alignment(0, 0),
          color: Colors.grey,
          height: 28,
          width: 120,
          child: Text("双击事件"),
        ),
      ),
    );
  }

  Widget buildLongTab() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onLongPress: () {
          print("长按事件 ");
          message = "长按事件 ";
          setState(() {});
        },
        child: Container(
          alignment: Alignment(0, 0),
          color: Colors.grey,
          height: 28,
          width: 120,
          child: Text("长按事件"),
        ),
      ),
    );
  }

  Widget buildDownUp() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTapDown: (tapDown) {
          print("按下 ");
          message = "按下 ";
          setState(() {});
        },
        onTapUp: (tapUp) {
          print("抬起 ");
          message = "抬起 ";
          setState(() {});
        },
        child: Container(
          alignment: Alignment(0, 0),
          color: Colors.grey,
          height: 28,
          width: 120,
          child: Text("监听按下与放开"),
        ),
      ),
    );
  }

  Widget buildOnTabInWell() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          print("InkWell单击事件 ");
          message = "InkWell单击事件 ";
          setState(() {});
        },
        child: Container(
          alignment: Alignment(0, 0),
          color: Colors.white54,
          height: 28,
          width: 120,
          child: Text("InkWell单击事件"),
        ),
      ),
    );
  }

  Widget buildOnTabInWell2() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        //按下去的颜色 或者说是说中状态的颜色
        highlightColor: Colors.blue[800],
        //点击时的水波纹颜色
        splashColor: Colors.yellow,
        hoverColor: Colors.red,
        focusColor: Colors.green,
        onTap: () {
          print("InkWell单击事件 ");
          message = "InkWell单击事件 ";
          setState(() {});
        },
        child: Container(
          alignment: Alignment(0, 0),
          height: 28,
          width: 120,
          child: Text("InkWell单击事件"),
        ),
      ),
    );
  }
}
