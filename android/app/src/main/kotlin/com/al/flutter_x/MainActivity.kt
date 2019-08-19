package com.al.flutter_x

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.AndroidToFlutterPlugins
import io.flutter.plugins.FlutterToAndroidPlugins
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.test.TestAndroidToFlutterPlugins
import io.flutter.test.TestFlutterToAndroidPlugins
import io.flutter.test.TestFluttertoAndroidTextViewPlugin
import io.flutter.webview.FluttertoAndroidWebViewPlugin

class MainActivity: FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    FlutterToAndroidPlugins.registerWith(this)
    AndroidToFlutterPlugins.registerWith(this)

    TestFlutterToAndroidPlugins.registerWith(this);
    TestFluttertoAndroidTextViewPlugin.registerWith(this);

    //注册webView plugin
    FluttertoAndroidWebViewPlugin.registerWith(this);
    //android 主动调用flutter
    TestAndroidToFlutterPlugins.registerWith(this);
  }

  override fun onDestroy() {
    super.onDestroy()

  }
}
