package io.flutter.call;

import android.util.Log;

import java.util.HashMap;

import android.content.Intent;

import io.flutter.PluginConfig;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class DealMethodCall {
	static String TAG = DealMethodCall.class.getSimpleName();
	
	/**
	 * flutter调用原生方法的回调
	 *
	 * @param activity   activity
	 * @param methodCall methodCall
	 * @param result     result
	 */
	public static void onMethodCall(FlutterActivity activity, MethodCall methodCall, final MethodChannel.Result result) {
		if (PluginConfig.methodTestNames.get("register").equals(methodCall.method)) {
			Log.e(TAG, "onMethodCall");
			//注册账号
			//此处处理业务（线程）
			result.success("succss");//处理后回调给Flutter
		}
		
	}
	
	
	/**
	 * 原生调用flutter方法的回调
	 *
	 * @param activity  activity
	 * @param o         o
	 * @param eventSink eventSink
	 */
	public static void onListen(FlutterActivity activity, Object o, EventChannel.EventSink eventSink) {
		//在此调用
		eventSink.success("onConnected");
		
	}
	
	/**
	 * 原生调用flutter方法的回调
	 *
	 * @param activity activity
	 * @param o        o
	 */
	public static void onCancel(FlutterActivity activity, Object o) {
	
	}
	
	private static MethodChannel.Result mScanResult;
	private static MethodChannel.Result mImageSelectResult;
	
	/**
	 * 扫码回调
	 * @param requestCode
	 * @param responseCode
	 * @param intent
	 */
	public static void onActivityResult(int requestCode, int responseCode, Intent intent) {
		if (mScanResult != null && requestCode == 22 && responseCode == 23) {
			mScanResult.success(intent.getStringExtra("codeUrl"));
		}
	}
	
	/**
	 * 相机 相册选择图片 回调
	 * @param imagePath
	 */
	public static void imageSelectCallBack(String imagePath) {
		if (mImageSelectResult != null ) {
			mImageSelectResult.success(imagePath);
		}
	}

}