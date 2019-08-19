import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/beans/beans.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/utils/utils.dart';
import 'package:flutter_x/view/likbutton_widget.dart';

class ArticleItem extends StatefulWidget {
  UserModel model;
  bool isHome;

  ArticleItem(this.model, this.isHome);

  @override
  State<StatefulWidget> createState() {
    return ArticleItemState(this.model, this.isHome);
  }
}

class ArticleItemState extends BasePage {
  final UserModel model;
  final bool isHome;

  ArticleItemState(this.model, this.isHome);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        //LogUtil.e("ReposModel: " + model.toString());
//        NavigatorUtil.pushWeb(context,
//            title: model.title, url: model.link, isHome: isHome);
      },
      child: new Container(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    model.nike,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: listTitle,
                  ),
                  Gaps.vGap10,
                  new Text(
                    model.sign == null ? "他很懒，什么也没有留下" : model.sign,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: listContent,
                  ),
                  Gaps.vGap5,
                ],
              )),
              new Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 12.0),
                child: new ClipOval(
                  child: CachedNetworkImage(
                      width: 66,
                      height: 66,
                      fit: BoxFit.fill,
                      imageUrl: model.headerImagUrl,
                      placeholder: (BuildContext context, String url) {
                        return buildProgressView();
                      },
                      errorWidget:
                          (BuildContext context, String url, Object error) {
                        return new Icon(Icons.error);
                      }),
                ),
              )
            ],
          ),
          decoration: new BoxDecoration(
              color: Colors.white,
              border:
                  new Border.all(width: 0.33, color: CommonColors.divider))),
    );
  }
}
