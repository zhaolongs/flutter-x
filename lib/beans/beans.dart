import 'package:azlistview/azlistview.dart';

class ComData {
  int size;
  List datas;

  ComData.fromJson(Map<String, dynamic> json)
      : size = json['size'],
        datas = json['datas'];
}

class ComReq {
  int cid;

  ComReq(this.cid);

  ComReq.fromJson(Map<String, dynamic> json) : cid = json['cid'];

  Map<String, dynamic> toJson() => {
        'cid': cid,
      };
}

class ComListResp<T> {
  int status;
  List<T> list;
  ComListResp(this.status, this.list);
}

class ReposModel {
  int id;
  int originId;
  String title = "flutter 看我看我个";
  String desc =
      "NoSuchMethodError: The getter 'scrollOffsetCorrection' was called on null";
  String author = "asc";
  String link;
  String projectLink;
  String envelopePic =
      "http://img5.duitang.com/uploads/item/201304/26/20130426105850_mh8aB.jpeg";
  String superChapterName;
  int publishTime = 1561994750000;
  bool collect;

  int type = 1; //1项目，2文章
  bool isShowHeader;

  ReposModel();

  ReposModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        originId = json['originId'],
        title = json['title'],
        desc = json['desc'],
        author = json['author'],
        link = json['link'],
        projectLink = json['projectLink'],
        envelopePic = json['envelopePic'],
        superChapterName = json['superChapterName'],
        publishTime = json['publishTime'],
        collect = json['collect'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'originId': originId,
        'title': title,
        'desc': desc,
        'author': author,
        'link': link,
        'projectLink': projectLink,
        'envelopePic': envelopePic,
        'superChapterName': superChapterName,
        'publishTime': publishTime,
        'collect': collect,
        'type': type,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"id\":$id");
    sb.write(",\"originId\":$originId");
    sb.write(",\"title\":\"$title\"");
    sb.write(",\"desc\":\"$desc\"");
    sb.write(",\"author\":\"$author\"");
    sb.write(",\"link\":\"$link\"");
    sb.write(",\"projectLink\":\"$projectLink\"");
    sb.write(",\"envelopePic\":\"$envelopePic\"");
    sb.write(",\"superChapterName\":\"$superChapterName\"");
    sb.write(",\"publishTime\":\"$publishTime\"");
    sb.write(",\"collect\":$collect");
    sb.write(",\"type\":$type");
    sb.write('}');
    return sb.toString();
  }
}

class BaseBean{
  BaseBean.fromJson(Map<String, dynamic> json);
}


class BannerModel extends BaseBean{
  /**
   * 1 为用户
   */
  int utype;
  UserModel user;

  BannerModel.fromJson(Map<String, dynamic> json)
      : utype = json['utype'],
        user = UserModel.fromJson(json['user']), super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'utype': utype,
        'user': user.toJson(),
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write('}');
    return sb.toString();
  }
}

class TreeModel extends ISuspensionBean {
  String name;
  int id;
  List<TreeModel> children;
  String tagIndex;

  TreeModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        children = (json['children'] as List)
            ?.map((e) => e == null
                ? null
                : new TreeModel.fromJson(e as Map<String, dynamic>))
            ?.toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'children': children,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"name\":\"$name\"");
    sb.write(",\"id\":$id");
    sb.write(",\"children\":$children");
    sb.write('}');
    return sb.toString();
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }
}

class LoginReq {
  String username;
  String password;

  LoginReq(this.username, this.password);

  LoginReq.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };

  @override
  String toString() {
    return '{' +
        " \"username\":\"" +
        username +
        "\"" +
        ", \"password\":\"" +
        password +
        "\"" +
        '}';
  }
}

class RegisterReq {
  String username;
  String password;
  String repassword;

  RegisterReq(this.username, this.password, this.repassword);

  RegisterReq.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        repassword = json['repassword'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'repassword': repassword,
      };

  @override
  String toString() {
    return '{' +
        " \"username\":\"" +
        username +
        "\"" +
        ", \"password\":\"" +
        password +
        "\"" +
        ", \"repassword\":\"" +
        repassword +
        "\"" +
        '}';
  }
}

class UserModel {
  int id;

  // 用户唯一标识符
  String useruid;

  // 姓名
  String username;

  // 密码
  String password;

  // 用户电话
  String phone;

  // 用户昵称
  String nike;
  String sign;

  // 用户头像
  String headerImagUrl;

  // 唯一校验码
  // 用户身份标识 0 超级管理员  1管理员  3 普通用户
  int identitys;

  String createTime;
  String createTimeStr;

  /**
   * 男1  女2
   */
  int gender;

  //其他用户是否关注
  bool isAttention;

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        nike = json['nike'],
        headerImagUrl = json['headerImagUrl'],
        sign=json['sign'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nike': nike,
        'username': username,
      };

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"id\":$id");
    sb.write(",\"username\":\"$username\"");
    sb.write(",\"password\":\"$password\"");
    sb.write('}');
    return sb.toString();
  }
}
