package io.flutter.test;

import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

import com.al.flutter_x.TestActivity;

import java.util.Map;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * flutter 调用 android 原生方法
 */
public class TestFlutterToAndroidPlugins implements MethodChannel.MethodCallHandler {
	
	private Context mContext;
	//Log TAG
	private String TAG = TestFlutterToAndroidPlugins.class.getSimpleName();
	
	//构造
	private TestFlutterToAndroidPlugins(FlutterActivity activity) {
		this.mContext = activity;
	}
	
	public static void registerWith(FlutterActivity activity) {
		
		//注册标识
		final String key = TestFlutterToAndroidPlugins.class.getCanonicalName();
		//防止多次注册
		if (activity.hasPlugin(key)) return;
		//创建TestFlutterToAndroidPlugins
		TestFlutterToAndroidPlugins instance = new TestFlutterToAndroidPlugins(activity);
		//flutter调用原生 注册通道
		MethodChannel channel = new MethodChannel(activity.registrarFor("com.flutter_to_native_test")
				.messenger(), "com.flutter_to_native_test");
		//setMethodCallHandler在此通道上接收方法调用的回调
		channel.setMethodCallHandler(instance);
	}
	
	/**
	 * flutter 调用 android 的消息接收处理方法
	 *
	 * @param methodCall
	 * @param result
	 */
	@Override
	public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
		//获取flutter中 设置method
		//也就是 TestInteractNative.goNativeWithValue("register") 中的 register
		String lMethod = methodCall.method;
		Log.d(TAG, "Android 原生方法中：onMethodCall--> lMethod:" + lMethod);
		
		//获取flutter 中传的参数
		Map<String, Object> lArguments = (Map<String, Object>) methodCall.arguments;
		if (lArguments != null) {
			for (Map.Entry<String, Object> lEntry : lArguments.entrySet()) {
				Log.d(TAG, "Android 原生方法中：lArguments--> [ key:" + lEntry.getKey() + " ; value :" + lEntry.getValue() + " ]");
			}
		}
		
		Toast.makeText(mContext, "android 原生方法 " + lMethod, Toast.LENGTH_SHORT).show();
		/**
		 * 在这里就可以处理android 方面的逻辑需要了，比如调用  扫一扫、相机 、录音、权限申请、Activity页面等等
		 * 然后再通过 result 回调 flutter 中
		 */
		
		if (lMethod.equals("openAndroidActivity")) {
			Intent lIntent = new Intent(mContext, TestActivity.class);
			mContext.startActivity(lIntent);
		
		}
		result.success("调用成功了");
	}
	
	
}