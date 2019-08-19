import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/beans/course_bean.dart';
import 'package:flutter_x/utils/route_utils.dart';
import 'package:flutter_x/utils/ui_util.dart';
import 'package:video_player/video_player.dart';

class CourseListItemPage extends StatefulWidget {
  CourseBean bean;

  CourseListItemPage(this.bean);

  @override
  State<StatefulWidget> createState() {
    return new UpRefreshPageViewPageState(bean);
  }
}

//BaseAppBarPageState 是封装的一个基类
class UpRefreshPageViewPageState extends BaseAppBarPageState<StatefulWidget> {
  CourseBean bean;

  UpRefreshPageViewPageState(this.bean);

  VideoPlayerController _controller;

  @override
  String buildInitState() {
    if (bean.videoUrl != null) {
      _controller = VideoPlayerController.network(bean.videoUrl)
        ..addListener(() {})
        ..initialize().then((_) {
          setState(() {
            _controller.play();
          });
        });
    }

    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
          ),
          //视频播放相关
          Center(
            child: (_controller != null)
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (_controller != null) {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          }
                        });
                      },
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(),
          ),

          _controller == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      bean.courseTitlePic != null
                          ? new CachedNetworkImage(
                              width: UiUtil.getDeviceWidth(context),
                              height: 220,
                              fit: BoxFit.fill,
                              imageUrl: bean.courseTitlePic,
                              placeholder: (context, url) =>
                                  buildProgressView(),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            )
                          : Container(),
                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      InkWell(
                        child: Text(
                          "查看详情",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          LogUtil.v(" 查看详情 ");
                          RouteUtil.pushArtPage(context, bean);
                        },
                      )
                    ],
                  ),
                )
              : Container(),

          //文章显示相关
          Positioned(
            bottom: 0,
            child: Container(
              color: Color.fromARGB(120, 0, 0, 0),
              padding:
                  EdgeInsets.only(bottom: 40, left: 20, top: 20, right: 100),
              width: UiUtil.getDeviceWidth(context),
              child: Container(
                width: UiUtil.getDeviceWidth(context) * 4.0 / 5,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        "@" + bean.courseCreateUserName.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.white54),
                      ),
                    ),
                    Container(
                      alignment: Alignment(-1, 0),
                      margin: EdgeInsets.only(top: 14),
                      child: Text(
                        "【" + bean.courseTitle.toString() + "】",
                        style: TextStyle(fontSize: 14, color: Colors.white54),
                      ),
                    ),
                    Container(
                      alignment: Alignment(-1, 0),
                      margin: EdgeInsets.only(top: 14),
                      child: Text(
                        bean.courseFlag,
                        style: TextStyle(fontSize: 14, color: Colors.white54),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//  {

//}
}
