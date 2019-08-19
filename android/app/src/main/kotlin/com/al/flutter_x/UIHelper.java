package com.al.flutter_x;

import android.annotation.SuppressLint;
import android.content.Context;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;


public class UIHelper {

    /**
     * 全局web样式
     */
    // 链接样式文件，代码块高亮的处理
    public final static String linkCss = "<script type=\"text/javascript\" " +
            "src=\"file:///android_asset/shCore.js\"></script>"
            + "<script type=\"text/javascript\" src=\"file:///android_asset/brush.js\"></script>"
            + "<script type=\"text/javascript\" src=\"file:///android_asset/client.js\"></script>"
            + "<script type=\"text/javascript\" src=\"file:///android_asset/detail_page" +
            ".js\"></script>"
            + "<script type=\"text/javascript\">SyntaxHighlighter.all();</script>"
            + "<script type=\"text/javascript\">function showImagePreview(var url){window" +
            ".location.url= url;}</script>"
            + "<link rel=\"stylesheet\" type=\"text/css\" " +
            "href=\"file:///android_asset/shThemeDefault.css\">"
            + "<link rel=\"stylesheet\" type=\"text/css\" href=\"file:///android_asset/shCore" +
            ".css\">"
            + "<link rel=\"stylesheet\" type=\"text/css\" href=\"file:///android_asset/css/common" +
            ".css\">";
    public final static String WEB_STYLE = linkCss;

    public static final String WEB_LOAD_IMAGES = "<script type=\"text/javascript\"> var " +
            "allImgUrls = getAllImgSrc(document.body.innerHTML);</script>";


    public static String setHtmlCotentSupportImagePreview(String body) {


        // 过滤掉 img标签的width,height属性
        body = body.replaceAll("(<img[^>]*?)\\s+width\\s*=\\s*\\S+", "$1");
        body = body.replaceAll("(<img[^>]*?)\\s+height\\s*=\\s*\\S+", "$1");
        // 添加点击图片放大支持
        // 添加点击图片放大支持
        body = body.replaceAll("(<img[^>]+src=\")(\\S+)\"",
                "$1$2\" onClick=\"showImagePreview('$2')\"");

        // 过滤table的内部属性
        body = body.replaceAll("(<table[^>]*?)\\s+border\\s*=\\s*\\S+", "$1");
        body = body.replaceAll("(<table[^>]*?)\\s+cellspacing\\s*=\\s*\\S+", "$1");
        body = body.replaceAll("(<table[^>]*?)\\s+cellpadding\\s*=\\s*\\S+", "$1");

        return body;
    }
//
//    /**
//     * 添加网页的点击图片展示支持
//     */
//    @SuppressLint({"JavascriptInterface", "SetJavaScriptEnabled"})
//    @JavascriptInterface
//    public static void addWebImageShow(final Context cxt, WebView wv) {
//        wv.getSettings().setJavaScriptEnabled(true);
//        wv.addJavascriptInterface(new OnWebViewImageListener() {
//            @Override
//            @JavascriptInterface
//            public void showImagePreview(String bigImageUrl) {
//                if (bigImageUrl != null && !StringUtils.isEmpty(bigImageUrl)) {
//                    LogUtils.d("显示大图");
////                    ImageGalleryActivity.show(cxt, bigImageUrl);
//                }
//            }
//        }, "mWebViewImageListener");
//    }
}
