import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/common/user_helper.dart';
import 'package:flutter_x/utils/route_utils.dart';

class LikeBtn extends StatelessWidget {
  const LikeBtn({
    Key key,
    this.labelId,
    this.id,
    this.isLike,
  }) : super(key: key);
  final String labelId;
  final int id;
  final bool isLike;

  @override
  Widget build(BuildContext context) {

    return new InkWell(
      onTap: () {
        if (UserHelper.getInstance().isLogin()) {
          // bloc.doCollection(labelId, id, !isLike);
        } else {
//          NavigatorUtil.pushPage(context, UserLoginPage(),
//              pageName: "UserLoginPage");
          RouteUtil.goLogin(context);
        }
      },
      child: new Icon(
        Icons.favorite,
        color: (isLike == true && UserHelper.getInstance().isLogin())
            ? Colors.redAccent
            : CommonColors.gray_99,
      ),
    );
  }
}