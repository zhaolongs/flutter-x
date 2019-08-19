package io.flutter;

import java.util.HashMap;

/**
 * Create by alv1 on 2019/6/19
 */
public class PluginConfig {
    /**
     * 通道名称，必须与flutter注册的一致
     */
    public static final String channels_flutter_to_native_view = "com.flutter_to_native_viewxx";
    public static final String channels_flutter_to_native_test = "com.flutter_to_nativexx";
    public static final String channels_native_to_flutter_test = "com.native_to_flutterxx";

    /**
     * 方法名称，必须与flutter注册的一致
     */
    public static final HashMap<String, String> methodTestNames = new HashMap<String, String>() {
        {
            put("register", "register");
            put("toast", "toast");
            put("camer", "camer");
            put("scan", "scan");
            put("audio_start", "audio_start");
            put("audio_stop", "audio_stop");

        }
    };

}
