package io.flutter.plugins;

import io.flutter.PluginConfig;
import io.flutter.app.FlutterActivity;
import io.flutter.call.DealMethodCall;
import io.flutter.plugin.common.EventChannel;

public class AndroidToFlutterPlugins implements EventChannel.StreamHandler{

    private FlutterActivity activity;

    private AndroidToFlutterPlugins(FlutterActivity activity) {
        this.activity = activity;
    }

    public static void registerWith(FlutterActivity activity) {
        AndroidToFlutterPlugins instance = new AndroidToFlutterPlugins(activity);
        //原生调用flutter
        EventChannel eventChannel = new EventChannel(activity.registrarFor(PluginConfig.channels_native_to_flutter_test)
                .messenger(), PluginConfig.channels_native_to_flutter_test);
        eventChannel.setStreamHandler(instance);
    }
    
    public static void imageSelectCallBack(String imagePath) {
        if (mEventSink != null) {
            mEventSink.success(imagePath);
        }
    }
    static EventChannel.EventSink mEventSink;
    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        DealMethodCall.onListen(activity, o, eventSink);
        mEventSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
        DealMethodCall.onCancel(activity, o);
    }
    
    
}