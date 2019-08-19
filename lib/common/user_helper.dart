import 'package:flustars/flustars.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'common.dart';

class UserHelper {
  static UserHelper mUserHelper;
  bool mIsLogin=false;
  BuildContext context;
  int homeBottomBarIndex;

  static UserHelper getInstance() {
    if (mUserHelper == null) {
      mUserHelper = new UserHelper();
    }
    return mUserHelper;
  }

  bool isLogin() {
    return mIsLogin;
  }
  void login(){
    mIsLogin=true;
  }
  void exitLogin(){
    mIsLogin=false;
  }

  void init(BuildContext context) {
    this.context = context;
    //设置的首页菜单样式
    this.homeBottomBarIndex = SpUtil.getInt(Constant.key_home_bottom,defValue: 4);
  }

  int getHomeBottomBar(){
    return homeBottomBarIndex;
  }
  void updateHomeBottomBar(int value){
    this.homeBottomBarIndex = value;
    SpUtil.putInt(Constant.key_home_bottom, value);
  }

}
