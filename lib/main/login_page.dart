import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/base/base_page.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/common/user_helper.dart';
import 'package:flutter_x/http/http_home_manager.dart';
import 'package:flutter_x/utils/toast.dart';


/**
 * 登录页面
 */
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends BasePage<StatefulWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isLogin = false;
  Animation<double> _buttonLengthAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));

    _buttonLengthAnimation = new Tween<double>(
      begin: 312.0,
      end: 42.0,
    ).animate(new CurvedAnimation(
        parent: _animationController, curve: new Interval(0.3, 0.6)))
      ..addListener(() {
        if (_buttonLengthAnimation.isCompleted) {
          LogUtil.v("login completed ");
          loginRequestFunction(context);
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      //显示在界面顶部的一个 AppBar
      //body：当前界面所显示的主要内容
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40, bottom: 30),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.only(left: 20.0),
                    child: new ClipRRect(
                      child: Image(
                        image: new AssetImage("images/flutter_x_icon.png"),
                        width: 44.0,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Flutter 传奇欢迎您 ",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            ),
            new Container(
              color: Colors.white,
              child: buildForm(),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController unameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  GlobalKey formKey = new GlobalKey<FormState>();

  Widget buildForm() {
    return Form(
      //设置globalKey，用于后面获取FormState
      key: formKey,
      //开启自动校验
      autovalidate: true,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          //包裹
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
                autofocus: false,
                keyboardType: TextInputType.number,
                //键盘回车键的样式
                textInputAction: TextInputAction.next,
                controller: unameController,
                decoration: InputDecoration(
                    labelText: "手机号",
                    hintText: "手机号",
                    icon: Icon(Icons.mobile_screen_share)),
                // 校验用户名
                validator: (v) {
                  return v.trim().length > 0 ? null : "手机号不能为空";
                }),
            Stack(
              children: <Widget>[
                TextFormField(
                  autofocus: false,
                  controller: pwdController,
                  decoration: InputDecoration(
                      labelText: "验证码",
                      hintText: "验证码",
                      icon: Icon(Icons.lock)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "验证码不能少于4位";
                  },
                ),
//                Positioned(
//                  right: 1,
//                  top: 20,
//                  child: new Container(
//                      padding: EdgeInsets.only(
//                          left: 12, right: 12, top: 8, bottom: 8),
//                      child: InkWell(
//                        onTap: () {
//                          print("获取验证码");
//                          if (_count == 0) {
//                            getTextCode();
//                          }
//                        },
//                        child: new Text(
//                          _codeText,
//                          style:
//                              new TextStyle(fontSize: 14.0, color: _codeColor),
//                        ),
//                      ),
//                      decoration: new BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
//                          border: new Border.all(
//                              width: 0.33, color: CommonColors.divider))),
//                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 28),
            ),
            new Material(
              child: new Ink(
                //用ink圆角矩形
//                color: Colors.red,
                decoration: new BoxDecoration(
                  /**
                   * assert(color == null || decoration == null,'Cannot provide both a color and
                   * a decoration\n'The color argument is just a shorthand
                   * for "decoration: new BoxDecoration(color: color)".')
                   * 在dart中使用assert 语句来中断正常的执行流程。
                   * “不能同时”使用Ink的变量color属性以及decoration属性，“两个只能存在一个”。
                   */
                  color: CommonColors.base_red_press,
                  borderRadius: new BorderRadius.all(new Radius.circular(22.0)),
                ),
                child: new InkWell(
                  borderRadius: new BorderRadius.circular(22.0), //给水波纹也设置同样的圆角
                  onTap: () {
                    print('% login %');
                    login();
                  },
                  child: new Container(
                    height: 44.0,
                    child: buildLogin(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogin() {
    return Container(
      width: _buttonLengthAnimation.value,
      alignment: Alignment.center,
      child: _buttonLengthAnimation.value > 75
          ? new Text("立即登录",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))
          : CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2,
            ),
    );
  }

  BorderRadius radius = BorderRadius.all(Radius.circular(21));

  void login() {
    //在这里不能通过此方式获取FormState，context不对
    //print(Form.of(context));
    // 通过_formKey.currentState 获取FormState后，
    // 调用validate()方法校验用户名密码是否合法，校验
    // 通过后再提交数据。
    if ((formKey.currentState as FormState).validate()) {
      //验证通过提交数据
      playAnimate(isLogin);
    }
  }

  Future<Null> playAnimate(bool isLogin)  async{
    _animationController.forward();
    try {
      if (isLogin) {
        await _animationController.forward();
      } else {
        await _animationController.forward();
        await _animationController.reverse();
      }
    } on TickerCanceled {
      // 自己处理动画取消
      print("结束");
    }
  }

  TimerUtil _timerUtil;
  int _count = 0;
  String _codeText = "获取验证码";
  Color _codeColor = Colors.red;

  void getTextCode() async {
    if (_timerUtil != null) {
      _timerUtil.cancel();
    }
// 初始化设置
    _timerUtil = new TimerUtil(mTotalTime: 60 * 1000);
    //设置计时回调 执行计时任务
    //这里只是更新了一个 文本显示
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
        LogUtil.v(" count is  " + _count.toString());
        _codeText = "已发送 $_count 秒";
        _codeColor = Colors.grey;
      });
      if (_tick == 0) {
        //跳转主页面
        _timerUtil.cancel();
        _codeText = "获取验证码";
        _codeColor = Colors.red;
      }
      setState(() {});
    });

    _timerUtil.startCountDown();



  }
  void showAlert(String text, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: new Text("提示"),
            content: new Text(text),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timerUtil.cancel();
  }

  void loginRequestFunction(BuildContext context) {
    UserHelper.getInstance().login();
    Navigator.pop(context);
//    homeManager.login("18603543572", "123456", (){
//
//    },errCallBack: (int code,String message){
//      LogUtil.v("code "+code.toString()+" message:"+message.toString());
//     // _animationController.reset();
//      _animationController.reverse();
//      Toast.toast(context,msg: message);
//    });
  }
}
