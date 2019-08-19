
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';

class UpPageViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UpPageViewPageState();
  }
}

class UpPageViewPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("pageView", backIcon: Icons.arrow_back_ios);
    return null;
  }
  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      child: PageView(
        children: buildPageItemView(),
        //设置滑动方向
        scrollDirection: Axis.vertical,
      ),
    );
  }

  buildPageItemView() {
    List<Widget> _pages =new List();
    for(int i=0;i<100;i++){
     Widget item = new ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: new CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
          imageUrl:
          "http://b-ssl.duitang.com/uploads/item/201311/02/20131102150044_YGB5u.jpeg",
          placeholder: (context, url) => new SizedBox(
            width: 24.0,
            height: 24.0,
            child: new CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
      );
     _pages.add(item);
    }
    return _pages;
  }
}
