import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_x/beans/beans.dart';
import 'package:flutter_x/common/config.dart';
import 'package:flutter_x/utils/base64utils.dart';

import 'base_resp.dart';

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @JianShu: https://www.jianshu.com/u/cbf2ad25d33a
 * @Email: 863764940@qq.com
 * @Description: Dio Util.
 * @Date: 2018/12/19
 */

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

///Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig({
    this.status,
    this.code,
    this.msg,
    this.data,
    this.options,
    this.pem,
    this.pKCSPath,
    this.pKCSPwd,
  });

  /// BaseResp [String status]字段 key, 默认：status.
  String status;

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String code;

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String msg;

  /// BaseResp [T data]字段 key, 默认：data.
  String data;

  /// Options.
  Options options;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;
}

/// 单例 DioUtil.
/// debug模式下可以打印请求日志. DioUtil.openDebug().
/// dio详细使用请查看dio官网(https://github.com/flutterchina/dio).
class DioUtil {
  static final DioUtil _singleton = DioUtil._init();
  static Dio _dio;

  /// BaseResp [String status]字段 key, 默认：status.
  String _statusKey = "status";

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String _codeKey = "code";

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String _msgKey = "message";

  /// BaseResp [T data]字段 key, 默认：data.
  String _dataKey = "content";

  /// Options.
  Options _options = getHttpDefaultOptions();

  /// PEM证书内容.
  String _pem;

  /// PKCS12 证书路径.
  String _pKCSPath;

  /// PKCS12 证书密码.
  String _pKCSPwd;

  /// 是否是debug模式.
  static bool _isDebug = true;

  static DioUtil getInstance() {
    return _singleton;
  }

  factory DioUtil() {
    return _singleton;
  }

  DioUtil._init() {
    _dio = new Dio();
    // 添加拦截器
    if (Config.DEBUG) {
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("\n================== 请求数据 ==========================");
        print("url = ${options.uri.toString()}");
        print("headers = ${options.headers}");
        print("params = ${options.data}");
        print("contentType = ${options.contentType}");
      }, onResponse: (Response response) {
        print("\n================== 响应数据 ==========================");
        print("code = ${response.statusCode}");
        print("data = ${response.data}");
        print("\n");
      }, onError: (DioError e) {
        print("\n================== 错误响应数据 ======================");
        print("type = ${e.type}");
        print("message = ${e.message}");
        print("stackTrace = ${e.stackTrace}");
        print("\n");
      }));
    }
  }

  /// 打开debug模式.
  static void openDebug() {
    _isDebug = true;
  }

  void setCookie(String cookie) {
    Map<String, dynamic> _headers = new Map();
    _headers["Cookie"] = cookie;
    _dio.options.headers.addAll(_headers);
  }

  Future requestGet<T extends BaseBean>(String url, Function callBack,
      {dynamic params, Function errorCallBack}) {
    FormData formData;
    if (params != null) {
      formData = new FormData.from(params);
    }
    return request<T>(Method.get, url, callBack,
        params: formData, errorCallBack: errorCallBack);
  }

  Future requestPost(String url, Function callBack,
      {Map<String, dynamic> params, Function errorCallBack}) {
    //StringBase64Utils.encodeBase64(
    //                  StringBase64Utils.encodeBase64(params.toString()))
    //              .toString()
    var encodeBase64 = StringBase64Utils.encodeBase64(
        StringBase64Utils.encodeBase64(params.toString()));
    print("<http> 加密前 " + params.toString());
    print("<http> 加密后 " + encodeBase64.toString());

    return request(Method.post, url, callBack,
        params: {"shop": encodeBase64}, errorCallBack: errorCallBack);
  }

  Future request<T extends BaseBean>(
      String method, String url, Function callBack,
      {params,
      Options options,
      CancelToken cancelToken,
      Function errorCallBack}) async {
    print("<http> url :<" + method + ">" + url);

    //Function callBack=httpCallBack;

    if (params != null && params.isNotEmpty) {
      print("<http> params :" + params.toString());
    }

    int statusCode;

    Response response;
    try {
      //组合GET请求的参数
      if (params != null && params is Map && params.isNotEmpty) {
        StringBuffer sb = new StringBuffer("?");
        params.forEach((key, value) {
          sb.write("$key" + "=" + "$value" + "&");
        });
        String paramStr = sb.toString();
        paramStr = paramStr.substring(0, paramStr.length - 1);
        url += paramStr;
      }

      if (method == Method.get) {
        response = await _dio.get(url);
      } else {
        if (params != null && params.isNotEmpty) {
//          Options options= new Options(contentType: ContentType("json", "application", charset: "utf-8"));
//          Options options= new Options(contentType: ContentType.parse("application/json"));
          Options options = new Options(
              contentType: ContentType.parse("text/plain;charset=UTF-8"),
              headers: {"contentType": "text/plain;charset=UTF-8"});
          response = await _dio.post(url, data: params, options: options);
        } else {
          response = await _dio.post(url);
        }
      }
    } catch (exception) {
      print("dio exception " + exception.toString());
      _handError(errorCallBack, statusCode);
      return Future.value();
    }
    statusCode = response.statusCode;
    var result = response.data;
    var code = 1000;
    var message = "请求成功";

    //处理错误部分
    if (statusCode != 200) {
      _handError(errorCallBack, statusCode);
    } else {
      if (response.data is Map) {
        result = response.data[_dataKey];
      } else {
        Map<String, dynamic> _dataMap = _decodeData(response);
        code = int.parse(_dataMap[_codeKey]);
        result = _dataMap[_dataKey];
        message = _dataMap[_msgKey];
      }
      if (code == 1000) {
        if (callBack != null) {
          callBack(result);
        }
      } else {
        if (errorCallBack != null) {
          errorCallBack(code, message);
        }
      }

      print("<http> response data:" + result.toString());
    }

    return result;
  }

  //处理异常
  static void _handError(Function errorCallback, int statusCode) {
    print("<http> statusCode :$statusCode");
    if (errorCallback != null) {
      errorCallback(-1, "网络连接失败");
    }
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  /// print Data Str.
  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }

  /// get dio.
  Dio getDio() {
    return _dio;
  }

  /// get Def Options.
  static Options getHttpDefaultOptions() {
    Options options = new Options();
    options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    options.connectTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    return options;
  }
}
