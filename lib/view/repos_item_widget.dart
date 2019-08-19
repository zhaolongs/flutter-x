import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/beans/beans.dart';
import 'package:flutter_x/beans/course_bean.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/res/TextStyles.dart';
import 'package:flutter_x/res/dimens.dart';
import 'package:flutter_x/res/textStyles.dart';
import 'package:flutter_x/utils/route_utils.dart';
import 'package:flutter_x/utils/utils.dart';
import 'package:flutter_x/view/likbutton_widget.dart';

class ReposItem extends StatefulWidget {
  CourseBean model;
  bool isHome;

  ReposItem(this.model, this.isHome);

  @override
  State<StatefulWidget> createState() {
    return ReposItemState(this.model, this.isHome);
  }
}

class ReposItemState extends BasePage {
  final CourseBean model;
  final bool isHome;

  ReposItemState(this.model, this.isHome);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {
        RouteUtil.pushArtPage(context, model);
      },
      child: new Container(
          height: 160.0,
          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 10),
          child: new Row(
            children: <Widget>[
              new Expanded(
                  child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    model.courseTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: listTitle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new Text(
                      model.courseFlag,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: listContent,
                    ),
                  ),
                  SizedBox(width: Dimens.gap_dp5),
                  new Row(
                    children: <Widget>[
                      new LikeBtn(
                        labelId: "",
                        isLike: model.isAttention,
                      ),
                      SizedBox(width: Dimens.gap_dp10),
                      new Text(
                        model.courseCreateUserName,
                        style: listExtra,
                      ),
                      SizedBox(width: Dimens.gap_dp10),
                      new Text(
                        "创作于 " +
                            Utils.getTimeLine(context, model.createTime)
                                .toString(),
                        style: listExtra,
                      ),
                    ],
                  )
                ],
              )),
              new Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 10.0),
                child: buildImage(),
              )
            ],
          ),
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border(
                  bottom: new BorderSide(
                      width: 0.33, color: CommonColors.divider)))),
    );
  }

  buildImage() {
    if (model.courseTitlePic == null) {
      return Container(
        color: Colors.grey,
        width: 100,
        height: 66,
      );
    }
    return new CachedNetworkImage(
      width: 100,
      height: 66,
      fit: BoxFit.fill,
      imageUrl: model.courseTitlePic,
      placeholder: (BuildContext context, String url) {
        return buildProgressView();
      },
      errorWidget: (BuildContext context, String url, Object error) {
        return new Icon(Icons.error);
      },
    );
  }
}
