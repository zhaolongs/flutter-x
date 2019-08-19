import 'package:flutter/services.dart';

/**
 * Flutter与Android  IOS  互调通信接口
 */
class TestInteractNative {
  //Flutter 调用 Android 原生 通道名称，必须与原生注册的一致
  //com.flutter_to_native_test 可以自己定义
  static const flutter_to_native =
      const MethodChannel('com.flutter_to_native_test');

  /*
   * 这里的书写方法 只是为了统计 互调的所有方法名称
   * 方法名称，必须与flutter注册的一致
   */
  static final Map<String, String> methodNames = const {
    'register': 'register',
  };

  /*
  * 调用原生的方法（带参）
  * @ methodName 是方法名称标识
  * @ map 是flutter 调用android ios 方法所传的参数
  */
  static Future<dynamic> goNativeWithValue(String methodName,
      [Map<String, String> map]) async {
    if (null == map) {
      //无参数传递
      dynamic future = await flutter_to_native.invokeMethod(methodName);
      return future;
    } else {
      //有参数传递
      dynamic future = await flutter_to_native.invokeMethod(methodName, map);
      return future;
    }
  }
}
