package com.al.flutter_x.view;

import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.Bitmap;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.ConsoleMessage;
import android.webkit.JavascriptInterface;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebStorage;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.TextView;

import com.al.flutter_x.UIHelper;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.PluginConfig;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class HtmlWebView implements PlatformView, MethodChannel.MethodCallHandler {
	
	private final WebView mWebView;
	private Context mContext;
	private static final String APP_CACAHE_DIRNAME = "/flutter_x/webcache";
	private float mMeasuredHeight;
	
	HtmlWebView(Context context, BinaryMessenger messenger, int id, Map<String, Object> params) {
		mContext = context;
		WebView lWebView = new WebView(context);
		ViewGroup.LayoutParams lLayoutParams = new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
		lWebView.setLayoutParams(lLayoutParams);
		initWebViewSettings(lWebView);
		this.mWebView = lWebView;
		
		MethodChannel methodChannel = new MethodChannel(messenger, PluginConfig.channels_flutter_to_native_view + id);
		methodChannel.setMethodCallHandler(this);
		
		//加载链接
		if (params.containsKey("url")) {
			String url = (String) params.get("url");
			
		} else if (params.containsKey("data")) {
			//加载html文件数据
			String artContent = (String) params.get("data");
			String[] split = artContent.split("</head>");
			if (split.length == 2) {
				StringBuilder stringBuilder = new StringBuilder(split[0]);
				stringBuilder.append("<meta name=\"viewport\" content=\"width=divice-width,initial-scale=1.0\" >\n");
				stringBuilder.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"file:///android_asset/sample-css.css\"/> \n");
				stringBuilder.append("<style>html{margin:0;padding:0;font-family: sans-serif;font-size:14px} body{margin:10px;padding:0} img{width:80%;height:auto;}</style>");
				stringBuilder.append("<script type=\"text/javascript\" src=\"file:///android_asset/client.js\"></script>");
				
				stringBuilder.append("</head>");
				stringBuilder.append(split[1]);
				
				artContent = stringBuilder.toString();
				
				if (artContent.contains("</body>")) {
					String[] bodySpilt = artContent.split("</body>");
					StringBuffer stringBuffer = new StringBuffer();
					stringBuffer.append(bodySpilt[0]);
					
					stringBuffer.append("<script type='text/javascript'>");
					stringBuffer.append("var list = document.getElementsByTagName('img');");
					stringBuffer.append("if (list != null) { ");
					
					
					stringBuffer.append("for (var i = 0; i < list.length; i++) { ");
					stringBuffer.append(" var im = list[i]; ");
					stringBuffer.append("im.style.cssText = 'max-width:96%;width:auto;height:auto;margin-left:1%;margin-rigth:1%;'");
					
					stringBuffer.append("}");
					stringBuffer.append("}");
					stringBuffer.append("</script>");
					
					stringBuffer.append("</body>");
					stringBuffer.append(bodySpilt[1]);
					
					artContent = stringBuffer.toString();
				}
				
				artContent = UIHelper.setHtmlCotentSupportImagePreview(artContent);
				mWebView.loadDataWithBaseURL(null, artContent, "text/html", "utf-8",
						null);
			} else {
				//ToastUtils.show("数据异常,请重新进入", mContext);
			}
			
		}
	}
	
	@Override
	public View getView() {
		return mWebView;
	}
	
	@Override
	public void dispose() {
	
	}
	
	private void initWebViewSettings(WebView webView) {
		//声明WebSettings子类
		WebSettings webSettings = webView.getSettings();
		
		//如果访问的页面中要与Javascript交互，则webview必须设置支持Javascript
		webSettings.setJavaScriptEnabled(true);
		
		//支持插件
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.FROYO) {
			webSettings.setPluginState(WebSettings.PluginState.ON);
		}
		
		//设置自适应屏幕，两者合用
		webSettings.setUseWideViewPort(true); //将图片调整到适合webview的大小
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR_MR1) {
			webSettings.setLoadWithOverviewMode(false); // 缩放至屏幕的大小
		}
		
		//缩放操作
		webSettings.setSupportZoom(false); //支持缩放，默认为true。是下面那个的前提。
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.CUPCAKE) {
			webSettings.setBuiltInZoomControls(false); //设置内置的缩放控件。若为false，则该WebView不可缩放
		}
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
			webSettings.setDisplayZoomControls(false); //隐藏原生的缩放控件
		}
		
		//设置缓冲大小，我设的是8M
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR_MR1) {
			webSettings.setAppCacheMaxSize(1024 * 1024 * 105);
			// 开启 DOM storage API 功能
			webSettings.setDomStorageEnabled(true);
			//开启 database storage API 功能
			webSettings.setDatabaseEnabled(true);
			
			//设置数据库缓存路径
			String cacheDirPath = mContext.getFilesDir().getAbsolutePath() + APP_CACAHE_DIRNAME;

//      String cacheDirPath = getCacheDir().getAbsolutePath()+Constant.APP_DB_DIRNAME;
			webSettings.setDatabasePath(cacheDirPath);
			
			//设置  Application Caches 缓存目录
			
			webSettings.setAppCachePath(cacheDirPath);
			//开启 Application Caches 功能
			webSettings.setAppCacheEnabled(true);
			webSettings.setAllowFileAccess(true);
			webSettings.setAppCacheEnabled(true);
			if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
				webSettings.setAllowFileAccessFromFileURLs(true);
				webSettings.setAllowUniversalAccessFromFileURLs(true);
			}
			webSettings.setCacheMode(WebSettings.LOAD_NO_CACHE);
			webSettings.setAllowFileAccess(true); //设置可以访问文件
		}
		
		webSettings.setRenderPriority(WebSettings.RenderPriority.HIGH);
		
		webSettings.setCacheMode(WebSettings.LOAD_DEFAULT);  //设置 缓存模式
		
		
		webSettings.setJavaScriptCanOpenWindowsAutomatically(true); //支持通过JS打开新窗口
		webSettings.setLoadsImagesAutomatically(true); //支持自动加载图片
		webSettings.setBlockNetworkImage(false);
		webSettings.setDefaultTextEncodingName("utf-8");//设置编码格式
		
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
			webSettings.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
		}
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
			webSettings.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
		}
		webView.addJavascriptInterface(new ReadFinishClass(), "controll");
		
		//获取网页对话框
		webView.setWebChromeClient(mWebChromeClient);
		
		webView.setWebViewClient(new CustomWebViewClient());
	}
	
	MethodChannel.Result mResult;
	
	// 在接口的回调方法中可以接收到来自Flutter的调用
	@Override
	public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
		if ("setText".equals(methodCall.method)) {
			String text = (String) methodCall.arguments;
			Log.d("methodCall", text + "  mMeasuredHeight " + mMeasuredHeight);
			//result.success(null);
			mResult = result;
			if (mMeasuredHeight != 0) {
				Map<String, Object> lMap = new HashMap<>();
				lMap.put("code", 200);
				lMap.put("message", "测量成功");
				lMap.put("content", mMeasuredHeight);
				mResult.success(lMap);
			}
		}
		
	}
	Handler mHandler = new Handler(Looper.myLooper());
	public class ReadFinishClass {
		/**
		 * 页面加载成功
		 */
		@JavascriptInterface
		public void pageFinish(final float height) {
			mMeasuredHeight = height;
			Log.e("webview ", "web view loading finish mMeasuredHeight " + mMeasuredHeight);
			if (mResult != null) {
				Map<String, Object> lMap = new HashMap<>();
				lMap.put("code", 200);
				lMap.put("message", "测量成功V");
				lMap.put("content", mMeasuredHeight);
				mHandler.post(new Runnable() {
					@Override
					public void run() {
						mResult.success(lMap);
					}
				});
				
			}
		}
		
		@JavascriptInterface
		public void showImagePreview(String bigImageUrl) {
//			if (bigImageUrl != null && !StringUtils.isEmpty(bigImageUrl)) {
//				LogUtils.d("图片 点击 " + bigImageUrl);
//				try {
//					JSONObject lJSONObject = new JSONObject(bigImageUrl);
//					String images = lJSONObject.getString("urls");
//					int index = lJSONObject.getInt("index");
//					ImageGalleryActivity.show(ArtDetaileActivity.this, images, index);
//				} catch (JSONException e) {
//					e.printStackTrace();
//				}
//
//			}
		}
	}
	
	private WebChromeClient mWebChromeClient = new WebChromeClient() {
		
		@Override
		public boolean onJsAlert(WebView view, String url, String message, JsResult result) {
			//构建一个来显示网页中的对话框
			return true;
		}
		
		@Override
		public boolean onJsConfirm(WebView view, String url, String message, JsResult result) {
			return true;
		}
		
		@TargetApi(Build.VERSION_CODES.FROYO)
		@Override
		public boolean onConsoleMessage(ConsoleMessage consoleMessage) {
			Log.d("webview", "console message is " + consoleMessage.message() + "\n\t\t from line " + consoleMessage.lineNumber() + "\n\t\t of"
					+ consoleMessage.sourceId());
			return true;
		}
		
		//加载进度
		@Override
		public void onProgressChanged(WebView view, int newProgress) {
			super.onProgressChanged(view, newProgress);
		}
		
		//扩充缓存的容量
		//webview可以设置一个WebChromeClient对象，在其onReachedMaxAppCacheSize函数对扩充缓冲做出响应
		@Override
		public void onReachedMaxAppCacheSize(long spaceNeeded,
											 long totalUsedQuota, WebStorage.QuotaUpdater quotaUpdater) {
			
		}
		
		/**
		 * 当WebView加载之后，返回 HTML 页面的标题 Title
		 * @param view
		 * @param title
		 */
		@Override
		public void onReceivedTitle(WebView view, String title) {
		
		
		}
	};
	
	
	private class CustomWebViewClient extends WebViewClient {
		private View mErrorView;
		
		@Override
		public boolean shouldOverrideUrlLoading(WebView view, String url) {
			mWebView.loadUrl(url);
			return true;
		}
		
		@Override
		public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
			Log.e("webview ", " shouldInterceptRequest");
			return super.shouldInterceptRequest(view, request);
		}
		
		@Override
		public WebResourceResponse shouldInterceptRequest(WebView view, String url) {
			Log.e("webview ", "webview  shouldInterceptRequest  url is " + url);
			return super.shouldInterceptRequest(view, url);
		}
		
		@Override
		public void onPageStarted(WebView view, String url, Bitmap favicon) {
			super.onPageStarted(view, url, favicon);
			Log.e("webview ", "web view loading start ");
		}
		
		@Override
		public void onPageFinished(WebView view, String url) {
			super.onPageFinished(view, url);
			
			Log.e("webview ", "web view loading finish " + url);
			mWebView.getSettings().setBlockNetworkImage(false);
			// mMainWebView.loadUrl("javascript:readBookDesPageFinish(" + mArticleModel.id + ")");
			mWebView.loadUrl("javascript:controll.pageFinish(document.body.getBoundingClientRect().height)");
			mWebView.loadUrl("javascript:getAllImgSrc(document.body.innerHTML)");
			
			
		}
		
		@Override
		public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {
			super.onReceivedError(view, request, error);
			if (error != null) {
				Log.e("webview", "web view loading err  " + error.toString());
			}
			
		}
		
		
	}
	
}