import 'package:flutter/material.dart';
import 'package:flutter_x/common/common_colors.dart';
import 'package:flutter_x/utils/utils.dart';

class HeaderItem extends StatelessWidget {
  HeaderItem(
      {this.margin,
      this.titleColor,
      this.leftIcon,
      this.title,
      this.extra,
      this.rightIcon,
      this.onTap,
      this.isRight,
      Key key})
      : super(key: key);

  final EdgeInsetsGeometry margin;
  final Color titleColor;
  final IconData leftIcon;
  final String title;
  bool isRight = true;
  final String extra;
  final IconData rightIcon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0,
      margin: margin ?? EdgeInsets.only(top: 0.0),
      child: new ListTile(
          onTap: onTap,
          title: new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Icon(
                leftIcon ?? Icons.whatshot,
                color: titleColor ?? Colors.blueAccent,
              ),
              new SizedBox(width: 10.0),
              new Expanded(
                  child: new Text(
                title ?? "推荐",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: titleColor ?? Colors.blueAccent,
                    fontSize: Utils.getTitleFontSize(title ?? "推荐")),
              ))
            ],
          ),
          trailing: new Row(
            mainAxisSize: MainAxisSize.min,
            children: (isRight==null||isRight) ? buildMore() : <Widget>[],
          )),
      decoration: new BoxDecoration(
          //new Border.all(width: 0.33, color: Colours.divider)
          border: new Border(
              bottom:
                  new BorderSide(width: 0.33, color: CommonColors.divider))),
    );
  }

  buildMore() {
    return <Widget>[
      new Text(
        extra ?? "更多",
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      new Icon(
        rightIcon ?? Icons.keyboard_arrow_right,
        color: Colors.grey,
      ),
    ];
  }
}
