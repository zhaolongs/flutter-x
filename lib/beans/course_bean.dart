import 'dart:core';

import 'beans.dart';

class CourseBean extends BaseBean{
  int readCount;

  //用户是否点赞
  bool isUserParise;

  //点赞总数
  int pariseCount;

  /**
   * 0 待审核
   * 1 审核通过
   * 2 未审核通过
   * 3 下架
   * 4
   */
  int statues;

  /**
   * id : 53
   * courseTitle : 步伐联系
   * courseFlag : 有助于快速掌握基本的步伐

   * courseRemark : 小白变大咖
   * createTime : 1541609947261
   * courseTitlePic : /study_ssm/upload/articles/pic/1541609895739.jpg
   * courseType : 2
   * courseUid : 768cf459c0b7420fbdc6891fd55d9f2d
   * courseCreateUserName : 18603543572
   * courseCreateUuserUid : 12we4
   * courseClassUid : 0e47994fbe0945b783935bf6da2e6a29
   * courseClassNname : wer
   * videoUrl : /study_ssm/upload/video/video/1541609902353.mp4
   */

  int id;
  String courseTitle;
  String courseFlag;
  String courseRemark;
  String artContent;
  int createTime;
  String courseTitlePic;
  bool isAttention;
  int courseType;
  String courseUid;
  String courseCreateUserName;
  String courseCreateUuserUid;
  String courseClassUid;
  String courseClassNname;
  String videoUrl;

  //图片标识
  String imageKey;

  //视频标识
  String videoKey;
  String artImageContent;

  CourseBean.fromJson(Map<String, dynamic> json)
      : courseTitle = json['courseTitle'],
        courseFlag = json['courseFlag'],
        courseCreateUuserUid= json['courseCreateUuserUid'],
        createTime = int.parse(json['createTime']),
        isAttention = json["isAttention"],
        courseTitlePic = json["courseTitlePic"],
        videoUrl = json["videoUrl"],
        courseCreateUserName = json["courseCreateUserName"],
        courseUid = json["courseUid"],
        id = json['id'], super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'courseUid': courseUid,
        'courseTitle': courseTitle,
        'courseFlag': courseFlag,
        'createTime': createTime,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"id\":$id");
    sb.write('}');
    return sb.toString();
  }
}
