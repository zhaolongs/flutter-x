package com.al.flutter_x.view;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * PlatformView flutter 中嵌入原生view 要求实现的接口
 * MethodChannel.MethodCallHandler 与原生view 通信的接口
 */
public class AndroidTextView implements PlatformView , MethodChannel.MethodCallHandler{
	
	private final TextView mTestTextView;
	
	/**
	 *
	 * @param context
	 * @param messenger
	 * @param id
	 * @param params  初始化时 flutter 传递过来的参数
	 */
	AndroidTextView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
		
		Log.d("testTextView ","testTextView");
		//创建 TextView
		TextView lTextView = new TextView(context);
		lTextView.setText("Android的原生TextView");
		this.mTestTextView = lTextView;
		
		//flutter 传递过来的参数
		if (params!=null&&!params.isEmpty()&&params.containsKey("content")) {
			String myContent = (String) params.get("content");
			lTextView.setText(myContent);
		}
//
		
		MethodChannel methodChannel = new MethodChannel(messenger, "com.flutter_to_native_test_view_" + id);
		methodChannel.setMethodCallHandler(this);
	}
	
	@Override
	public View getView() {
		return mTestTextView;
	}
	
	@Override
	public void dispose() {
	
	}
	
	@Override
	public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
		if ("setText".equals(methodCall.method)) {
			String text = (String) methodCall.arguments;
			this.mTestTextView .setText(text);
			result.success(null);
		}
	}
}