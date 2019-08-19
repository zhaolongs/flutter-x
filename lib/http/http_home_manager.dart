import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_x/beans/beans.dart';
import 'package:flutter_x/beans/course_bean.dart';
import 'package:flutter_x/utils/md5utils.dart';

import 'api/apis.dart';
import 'base_resp.dart';
import 'dio_util.dart';

class HttpHomeManager {
  /**
   * 加载 首页面 Banner
   */
  void getBanner(Function callback, {Function errCallBack}) {
    DioUtil.getInstance().requestGet<BannerModel>(HttpUrlHelper.BANNER,
        (List result) {
      print("加载 首页面 Banner " + result.toString());
      List<BannerModel> bannerList = result.map((value) {
        BannerModel bannerModel = BannerModel.fromJson(value);
        return bannerModel;
      }).toList();
      callback(bannerList);
    });
//
  }

  void getCourse(Function callback,
      {int pageSize = 4,
      int loadType = 0,
      int pageIndex = 0,
      Function errCallBack}) {
    Map<String, dynamic> parameterMap = Map();
    parameterMap["pageIndex"] = pageIndex;
    parameterMap["pageSize"] = pageSize;
    parameterMap["loadtype"] = loadType;
    DioUtil.getInstance().requestGet(HttpUrlHelper.CourseUrl, (List result) {
      List<CourseBean> courseList;
      courseList = result.map((value) {
        return CourseBean.fromJson(value);
      }).toList();
      if (callback != null) {
        callback(1000, courseList);
      }
    });
  }

  getUserList(Function callback, {Function errCallBack}) {
    Map<String, dynamic> parameterMap = Map();
    parameterMap["pageIndex"] = 0;
    parameterMap["pageSize"] = 4;
    DioUtil.getInstance().requestGet(HttpUrlHelper.appHomeUserListUrl,
        (List result) {
      List<UserModel> courseList;
      courseList = result.map((value) {
        return UserModel.fromJson(value);
      }).toList();
      if (callback != null) {
        callback(1000, courseList);
      }
    }, params: parameterMap, errorCallBack: () {});
  }

  Future<String> login(String phone, String password, Function callback,
      {Function errCallBack}) async {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strlenght = 30;

    /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
// right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    print(left);

    var nowDateMs = DateUtil.getNowDateMs();
    nowDateMs = 1562988569028;
    left = "WBBAWdalXTkDmHGXgKczVNqvVeGowI";
    var signflag = "6ebb8f0afb8659c3a84af65bb135e201";
    //Md5Utils.generateMd5(left.toString() + nowDateMs.toString())
    var parameterMap = Map();
    parameterMap["phone"] = phone;
    parameterMap["passwords"] = password;
    parameterMap["signtimes"] = nowDateMs;
    parameterMap["signuid"] = left;
    parameterMap["signflag"] = signflag;
  }

  void getCourseDes(
      String courseUid,
      String artUserUid,
      Null Function(String content) callBack,
      Null Function(int code, String errMessage) errCallback) {
    Map<String, dynamic> parameterMap = Map();
    parameterMap["\"courseUid\""] = "\"" + courseUid.toString() + "\"";
    parameterMap["\"artUserUid\""] = "\"" + artUserUid.toString() + "\"";

    DioUtil.getInstance().requestPost(HttpUrlHelper.CourseDesUrl, (result) {
      if (callBack != null) {
        callBack(result["artContent"]);
      }
    }, errorCallBack: errCallback, params: parameterMap);
  }
  void getCourseUserInfo(
      String userUid,
      Null Function(UserModel userModel) callBack,
      Null Function(int code, String errMessage) errCallback) {
    Map<String, dynamic> parameterMap = Map();
    parameterMap["\"useruid\""] = "\"" + userUid.toString() + "\"";


    DioUtil.getInstance().requestPost(HttpUrlHelper.courseUserInfoUrl, (result) {
      if (callBack != null) {
        callBack(UserModel.fromJson(result));
      }
    }, errorCallBack: errCallback, params: parameterMap);
  }

}
