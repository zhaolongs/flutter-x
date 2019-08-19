package io.flutter.plugins;

import android.content.Intent;

import com.al.flutter_x.test.TestViewFactory;
import com.al.flutter_x.view.ViewFactory;

import io.flutter.PluginConfig;
import io.flutter.app.FlutterActivity;
import io.flutter.call.DealMethodCall;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * flutter 调用 android 原生方法
 */
public class FlutterToAndroidPlugins implements MethodChannel.MethodCallHandler {

    private FlutterActivity activity;

    private FlutterToAndroidPlugins(FlutterActivity activity) {
        this.activity = activity;
    }

    public static void registerWith(FlutterActivity activity) {
    
        final String key = FlutterToAndroidPlugins.class.getCanonicalName();
        if (activity.hasPlugin(key)) return;
    
        PluginRegistry.Registrar registrar = activity.registrarFor(key);
        registrar.platformViewRegistry().registerViewFactory(PluginConfig.channels_flutter_to_native_view, new ViewFactory(registrar.messenger()));
    
    
        FlutterToAndroidPlugins instance = new FlutterToAndroidPlugins(activity);
        //flutter调用原生
        MethodChannel channel = new MethodChannel(activity.registrarFor(PluginConfig.channels_flutter_to_native_test)
                .messenger(), PluginConfig.channels_flutter_to_native_test);
        //setMethodCallHandler在此通道上接收方法调用的回调
        channel.setMethodCallHandler(instance);
    }
    
    public static void imageSelectCallBack(String imagePath) {
        DealMethodCall.imageSelectCallBack(imagePath);
    }
	
	@Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        DealMethodCall.onMethodCall(activity, methodCall, result);
    }
    
    public static  boolean onActivityResult(int i, int i1, Intent intent) {
        DealMethodCall.onActivityResult(i,i1,intent);
        return false;
    }
}