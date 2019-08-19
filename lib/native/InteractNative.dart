import 'package:flutter/services.dart';

/**
 * Android  IOS 与 Flutter 互调通信接口
 */
class InteractNative {
  /*Flutter 调用 Android 原生 通道名称，必须与原生注册的一致*/
  static const flutter_to_native = const MethodChannel('com.flutter_to_native_viewxx');

  static const flutter_to_native_view = const MethodChannel('com.flutter_to_nativexx');

  /* Android 原生调用Flutter  通道名称，必须与原生注册的一致*/
  static const native_to_flutter = const EventChannel('com.native_to_flutterxx');

  /*
   * 这里的书写方法 只是为了统计 互调的所有方法名称
   * 方法名称，必须与flutter注册的一致
   */
  static final Map<String, String> methodNames = const {
    'register': 'register',
    'scan': 'scan',
    'camer': 'camer',
    'audio_start': 'audio_start',
    'audio_stop': 'audio_stop',
    'choose_image': 'choose_image',
  };

  /*
  * 调用原生的方法（带参）
  */
  static Future<dynamic> goNativeWithValue(String methodName,
      [Map<String, String> map]) async {
    if (null == map) {
      dynamic future = await flutter_to_native.invokeMethod(methodName);
      return future;
    } else {
      dynamic future = await flutter_to_native.invokeMethod(methodName, map);
      return future;
    }
  }

  static Future<Map> takePhoto()  async {
    Map result = await flutter_to_native.invokeMethod('camer');
    return result;
  }

  static Future<Map> choosePhoto() async {
    Map result = await flutter_to_native.invokeMethod('choose_image');
    return result;
  }

  /*
  * 原生回调的方法（带参）
  *
      StreamSubscription _subscription = InteractNative.dealNativeWithValue()
          .listen(_onEvent, onError: _onError);
            void _onEvent(Object event) {
    if ('onConnected' == event) {
//        DialogUtil.buildToast('已连接');
    }
  }

  void _onError(Object error) {
    DialogUtil.buildToast(error.toString());
  }
  */
  static Stream<dynamic> dealNativeWithValue() {
    Stream<dynamic> stream = native_to_flutter.receiveBroadcastStream();
    return stream;
  }

  static Future<dynamic> openCamer() async {
    dynamic future = await flutter_to_native.invokeMethod("camer");
    return future;
  }
}
