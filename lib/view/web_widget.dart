import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class WebViewWidget extends StatefulWidget {
  const WebViewWidget({
    Key key,
    this.title,
    this.url,
    this.isShowFloatBtn = false,
  }) : super(key: key);

  //显示标题
  final String title;

  //加载链接
  final String url;
  final bool isShowFloatBtn;

  @override
  State<StatefulWidget> createState() {
    return new WebViewWidgetState(title, url);
  }
}

class WebViewWidgetState extends BaseAppBarPageState<StatefulWidget> {
//  WebViewController _webViewController;
  bool isShowFloatBtn = false;
  String title;
  String url;

  WebViewWidgetState(this.title, this.url, {this.isShowFloatBtn});

  @override
  String buildInitState() {
    buildBackBar(title, backIcon: Icons.arrow_back_ios);
    return title;
  }

  @override
  Widget buildWidget(BuildContext context) {
  }
}
// TODO: implement buildWidget
//    return new WebView(
//      onWebViewCreated: (WebViewController webViewController) {
//        _webViewController = webViewController;
//      },
//      initialUrl: url,
//      javascriptMode: JavascriptMode.unrestricted,
//    );
//  }

//  Widget _buildFloatingActionButton() {
//    if (_webViewController == null || _webViewController.scrollY < 480) {
//      return null;
//    }
//    return new FloatingActionButton(
//        heroTag: title,
//        backgroundColor: Theme.of(context).primaryColor,
//        child: Icon(
//          Icons.keyboard_arrow_up,
//        ),
//        onPressed: () {
//          _webViewController.scrollTop();
//        });
//  }
//}
