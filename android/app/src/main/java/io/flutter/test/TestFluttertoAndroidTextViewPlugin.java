package io.flutter.test;

import com.al.flutter_x.test.TestViewFactory;

import io.flutter.plugin.common.PluginRegistry;


/**
 * flutter 调用 android 原生view
 *
 */
public class TestFluttertoAndroidTextViewPlugin {
	public static void registerWith(PluginRegistry registry) {
		//防止多次注册
		final String key = TestFluttertoAndroidTextViewPlugin.class.getCanonicalName();
		if (registry.hasPlugin(key)) return;
		//初始化 PluginRegistry
		PluginRegistry.Registrar registrar = registry.registrarFor(key);
		//设置标识
		registrar.platformViewRegistry().registerViewFactory("com.flutter_to_native_test_textview", new TestViewFactory(registrar.messenger()));
	}
}