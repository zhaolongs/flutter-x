package com.al.flutter_x.utils;

import android.content.Context;

import com.al.flutter_x.webview.DropDownSpringbackScrollView;

public class ScrollViewSetingUtils {
	private Context mContext;
	private DropDownSpringbackScrollView mScrollView;
	public void initScrollView(Context context, DropDownSpringbackScrollView scrollView){
		this.mContext= context;
		this.mScrollView = scrollView;
		
	}
}
