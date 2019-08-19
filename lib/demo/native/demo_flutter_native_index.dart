import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/native/InteractNative.dart';

import 'TestInteractNative.dart';
import 'TestNative.dart';

class FlutterNativePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MenuIndexPageState();
  }
}

class MenuIndexPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("Flutter 调用原生 代码", backIcon: Icons.arrow_back_ios);
    if (Platform.isIOS) {
      //ios相关代码
      buttonText = "Ios";
    } else if (Platform.isAndroid) {
      //android相关代码
      buttonText = "Android";
    }


    return null;
  }

  String testText = "";
  String buttonText = "";

  @override
  Widget buildWidget(BuildContext context) {
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            testText,
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
        buildWhiteFlatButton("flutter调用" + buttonText.toString() + "原生", () {
          defaultTest();
        }),
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        buildWhiteFlatButton("flutter调用" + buttonText.toString() + "原生 传参数",
            () {
          defaultTestAndPara();
        }),

        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        buildWhiteFlatButton("flutter 打开" + buttonText.toString() + "原生 页面",
            () {
          //flutter 调用原生方法
          //register 只是通信方法的一个标识，可以设置不同的值，以调用原生不同的方法
          TestInteractNative.goNativeWithValue("openAndroidActivity")
              .then((value) {
            //then 方法中处理回调
            print("register TestInteractNative response  " + value.toString());
            //更新flutter中的数据显示

            //设置 Android 调用监听
            TestNative.dealNativeWithValue((Map map) {
              int code = map["code"];
              String message = map["message"];
              if (code == 100) {
                print("_subscription " + message.toString());
              } else if (code == 200) {
                int content = map["content"];
                print("_subscription click " + content.toString());
              }
            }, errCallBack: (object) {
              print(" 连接异常 " + object.toString());
            });


            setState(() {
              testText = value.toString();
            });
          });
        }),
      ],
    );
  }

  void defaultTest() {
    //flutter 调用原生方法
    //register 只是通信方法的一个标识，可以设置不同的值，以调用原生不同的方法
    TestInteractNative.goNativeWithValue("register").then((value) {
      //then 方法中处理回调
      print("register TestInteractNative response  " + value.toString());
      //更新flutter中的数据显示
      setState(() {
        testText = value.toString();
      });
    });
  }

  void defaultTestAndPara() {
    //参数相关
    Map<String, String> map = new Map();
    map["pageIndex"] = "1";
    map["pageSize"] = "10";
    //flutter 调用原生方法
    //register 只是通信方法的一个标识，可以设置不同的值，以调用原生不同的方法
    TestInteractNative.goNativeWithValue("register", map).then((value) {
      //then 方法中处理回调
      print("register TestInteractNative response  " + value.toString());
      //更新flutter中的数据显示
      setState(() {
        testText = value.toString();
      });
    });
  }
}
