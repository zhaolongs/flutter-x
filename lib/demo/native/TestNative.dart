import 'package:flutter/services.dart';

class TestNative {
  /* Android 原生调用Flutter  通道名称，必须与原生注册的一致*/
  static const native_to_flutter =
      const EventChannel('com.native_to_flutter_test');

  //注册监听
  // callback 为android ios 回调方法
  // errCallBack 为异常回调方法
  static Stream<dynamic> dealNativeWithValue(
      Function(Map<dynamic, dynamic> map) callback,
      {Function(Object object) errCallBack}) {
    Stream<dynamic> stream = native_to_flutter.receiveBroadcastStream()
      ..listen((Object event) {
        //连接成功后 android 调用会回调此方法
        if (event is Map) {
          callback(event);
        } else {
          //未知类型回调
        }
      }, onError: (Object event) {
        //连接异常
        if (errCallBack != null) {
          errCallBack(event);
        }
      });

    return stream;
  }
}
