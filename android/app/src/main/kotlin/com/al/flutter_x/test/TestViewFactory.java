package com.al.flutter_x.test;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * 用于创建 TextView
 */
public class TestViewFactory extends PlatformViewFactory {
	private final BinaryMessenger messenger;
	
	public TestViewFactory(BinaryMessenger messenger) {
		super(StandardMessageCodec.INSTANCE);
		this.messenger = messenger;
	}
	
	/**
	 * @param context
	 * @param id
	 * @param args    args是由Flutter传过来的自定义参数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public PlatformView create(Context context, int id, Object args) {
		//flutter 传递过来的参数
		Map<String, Object> params = (Map<String, Object>) args;
		//创建 TestTextView
		return new TestTextView(context, messenger, id, params);
		
	}
}