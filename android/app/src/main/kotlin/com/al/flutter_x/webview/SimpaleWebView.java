package com.al.flutter_x.webview;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.widget.Toast;
import java.util.Map;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

public class SimpaleWebView implements PlatformView {
	
	private WebView mWebView;
	
	SimpaleWebView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
		
		//创建webview
		WebView lWebView = new WebView(context);
		ViewGroup.LayoutParams lLayoutParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
		lWebView.setLayoutParams(lLayoutParams);
		this.mWebView = lWebView;
		//加载链接
		if (params != null && params.containsKey("url")) {
			//通过 url 来加载页面
			String url = (String) params.get("url");
			mWebView.loadUrl(url);
		} else if (params != null && params.containsKey("data")) {
			//加载html文件数据
			String artContent = (String) params.get("data");
			//加载html代码块
			mWebView.loadDataWithBaseURL(null, artContent, "text/html", "utf-8", null);
		} else {
			Toast.makeText(context, "数据异常,请重新进入", Toast.LENGTH_SHORT).show();
		}
		
	}
	
	@Override
	public View getView() {
		return mWebView;
	}
	
	@Override
	public void dispose() {
		mWebView = null;
	}
	
}