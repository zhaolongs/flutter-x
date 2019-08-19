package io.flutter.webview;


import com.al.flutter_x.webview.WebViewViewFactory;
import io.flutter.plugin.common.PluginRegistry;

/**
 * flutter 调用 android 原生 WebView
 *
 */
public class FluttertoAndroidWebViewPlugin {
	public static void registerWith(PluginRegistry registry) {
		//防止多次注册
		final String key = FluttertoAndroidWebViewPlugin.class.getCanonicalName();
		if (registry.hasPlugin(key)) return;
		//初始化 PluginRegistry
		PluginRegistry.Registrar registrar = registry.registrarFor(key);
		//设置标识
		registrar.platformViewRegistry().registerViewFactory("com.flutter_to_native_webviewxx", new WebViewViewFactory(registrar.messenger()));
	}
}