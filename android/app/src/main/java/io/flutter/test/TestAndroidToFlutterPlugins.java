package io.flutter.test;


import java.util.HashMap;
import java.util.Map;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;

public class TestAndroidToFlutterPlugins implements EventChannel.StreamHandler{

    private FlutterActivity activity;

    private TestAndroidToFlutterPlugins(FlutterActivity activity) {
        this.activity = activity;
    }

    public static void registerWith(FlutterActivity activity) {
        TestAndroidToFlutterPlugins instance = new TestAndroidToFlutterPlugins(activity);
        //原生调用flutter
        //com.native_to_flutter_test 为通道标识
        EventChannel eventChannel = new EventChannel(activity.registrarFor("com.native_to_flutter_test")
                .messenger(), "com.native_to_flutter_test");
        eventChannel.setStreamHandler(instance);
    }
    
    //android 调用 flutter
    public static void post(Map<String,Object> map) {
        if (mEventSink != null) {
            mEventSink.success(map);
        }
    }
    static EventChannel.EventSink mEventSink;
    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        mEventSink = eventSink;
        //连接成功时向Flutter 中发送一条信息
        HashMap<String, Object> lStringObjectHashMap = new HashMap<>();
        lStringObjectHashMap.put("code",100);
        lStringObjectHashMap.put("message","连接成功");
        mEventSink.success(lStringObjectHashMap);
    }

    @Override
    public void onCancel(Object o) {
    
    }
    
    
}