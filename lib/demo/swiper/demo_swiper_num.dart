import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_x/base/base_appbar_page.dart';
import 'package:flutter_x/utils/route_utils.dart';

class SwiperViewNumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SwiperViewNumPageState();
  }
}

class SwiperViewNumPageState extends BaseAppBarPageState<StatefulWidget> {
  @override
  String buildInitState() {
    buildBackBar("轮播图", backIcon: Icons.arrow_back_ios);

    return null;
  }

  @override
  Widget buildWidget(BuildContext context) {
    print("build --");
    return new Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
        ),
        buildStyle1(),

        Padding(
          padding: EdgeInsets.all(30),
        ),
        //LinearProgressIndicator不具备设置高度的选项，可以使用SizedBox来设置高度与宽度
      ],
    );
  }

  //自定义分页指示器
  buildSwiperPagination() {
    // 分页指示器
    return SwiperPagination(
      //指示器显示的位置
      alignment: Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
      // 距离调整
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      // 指示器构建
      builder: FractionPaginationBuilder(
          // 选中时字体大小
          activeFontSize: 14,
          // 字体大小
          fontSize: 14,
           // 字体颜色
          color: Colors.red,
          //选中时的颜色
          activeColor: Colors.blue),
    );
  }

  //定义轮播图组件
  Widget buildStyle1() {
    return Container(
      height: 200.0,
      child: new Swiper(
        // 横向
        scrollDirection: Axis.horizontal,
        // 布局构建
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://hbimg.b0.upaiyun.com/a3e592c653ea46adfe1809e35cd7bc58508a6cb94307-aaO54C_fw658",
            fit: BoxFit.fill,
          );
        },
        //条目个数
        itemCount: 6,
        // 自动翻页
        autoplay: true,
        // 分页指示
        pagination: buildSwiperPagination(),
        //点击事件
        onTap: (index) {
          print(" 点击 " + index.toString());
        },
        // 视窗比例
        viewportFraction: 1,
        // 布局方式
        //layout: SwiperLayout.STACK,
        // 用户进行操作时停止自动翻页
        autoplayDisableOnInteraction: true,
        // 无线轮播
        loop: true,
        scale: 1,
      ),
    );
  }
}
