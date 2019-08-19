import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

class AndroidTextViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MenuIndexPageState();
  }
}

class MenuIndexPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("调用Android原生View", backIcon: Icons.arrow_back_ios);

    return null;
  }

  Widget mTextWidget;
  MethodChannel _channel;
  int viewId = -1;

  @override
  Widget buildWidget(BuildContext context) {
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(30),
          child: mTextWidget == null ? Container() : mTextWidget,
        ),
        //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
        buildWhiteFlatButton("简单使用", () {
          mTextWidget = Container(
            height: 200,
            child: AndroidView(
              viewType: "com.flutter_to_native_test_textview",
            ),
          );
          setState(() {});
        }),
        buildWhiteFlatButton("传参数", () {
          setState(() {
            mTextWidget = Container(
              height: 200,
              child: AndroidView(
                //标识
                viewType: "com.flutter_to_native_test_textview",
                creationParams: {
                  "content": "flutter 传入的文本内容",
                },
                //参数的编码方式
                creationParamsCodec: const StandardMessageCodec(),
              ),
            );
          });
        }),
        buildWhiteFlatButton("textview 创建完成时的回调", () {
          mTextWidget = Container(
            height: 200,
            child: AndroidView(
              //标识
              viewType: "com.flutter_to_native_test_textview",
              creationParams: {
                "content": "flutter 传入的文本内容",
              },
              //参数的编码方式
              creationParamsCodec: const StandardMessageCodec(),
              //view创建完成时的回调
              onPlatformViewCreated: (id) {
                viewId = id;
                print("view创建完成时的回调 " + id.toString());
              },
            ),
          );
          setState(() {});
        }),
        buildWhiteFlatButton("更新 textView 内容", () {
          if (mTextWidget == null || viewId == -1) {
            mTextWidget = Container(
              height: 200,
              child: AndroidView(
                //标识
                viewType: "com.flutter_to_native_test_textview",
                creationParams: {
                  "content": "flutter 传入的文本内容",
                },
                //参数的编码方式
                creationParamsCodec: const StandardMessageCodec(),
                //view创建完成时的回调
                onPlatformViewCreated: (id) {
                  viewId = id;
                },
              ),
            );
            setState(() {});
          } else {
            _channel = new MethodChannel(
                'com.flutter_to_native_test_textview_$viewId');
            updateTextView();
          }
        }),
      ],
    );
  }

  void updateTextView() async {
    return _channel.invokeMethod('updateText', "更新内容");
  }
}
