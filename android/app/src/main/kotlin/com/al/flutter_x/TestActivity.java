package com.al.flutter_x;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import java.util.HashMap;

import io.flutter.test.TestAndroidToFlutterPlugins;

public class TestActivity extends Activity {
	private int mClickCount=0;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_test_layout);
		
		TextView openFlutterTextView = findViewById(R.id.tv_open_flutter);
		
		openFlutterTextView.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View view) {
				mClickCount++;
				HashMap<String, Object> lStringObjectHashMap = new HashMap<>();
				lStringObjectHashMap.put("content",mClickCount);
				lStringObjectHashMap.put("code",200);
				lStringObjectHashMap.put("message","android 中 click");
				//调用 Flutter
				TestAndroidToFlutterPlugins.post(lStringObjectHashMap);
			}
		});
	}
}
