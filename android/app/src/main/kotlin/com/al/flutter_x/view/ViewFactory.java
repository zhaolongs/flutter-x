package com.al.flutter_x.view;

import android.content.Context;

import com.al.flutter_x.test.TestTextView;
import com.al.flutter_x.test.TestWebView;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class ViewFactory extends PlatformViewFactory {
	private final BinaryMessenger messenger;
	public ViewFactory(BinaryMessenger messenger) {
		super(StandardMessageCodec.INSTANCE);
		this.messenger = messenger;
	}
	
	/**
	 *
	 * @param context
	 * @param id
	 * @param args  args是由Flutter传过来的自定义参数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public PlatformView create(Context context, int id, Object args) {
		//flutter 传递过来的参数
		Map<String, Object> params = (Map<String, Object>) args;
		//根据参数标识来加载不同的原生View
		String lFlag =null;
		if (params!=null&&!params.isEmpty()&&params.containsKey("flag")){
			lFlag= (String) params.get("flag");
		}
		if (lFlag!=null) {
			if (lFlag!=null&lFlag.equals("webview")){
				//加载webview
				return new HtmlWebView(context, messenger, id, params);
			}else {
				//返回默认View
				return new AndroidTextView(context, messenger, id, params);
			}
		}else {
			//返回默认View
			return new AndroidTextView(context, messenger, id, params);
		}
	}
}