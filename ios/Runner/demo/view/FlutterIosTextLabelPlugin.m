//
//  FlutterIosTextLabelPlugin.m
//  Runner
//
//  Created by  androidlongs on 2019/7/16.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "FlutterIosTextLabelPlugin.h"
#import "FlutterIosWebViewFactory.h"
#import "FlutterIosTextLabelFactory.h"


@implementation FlutterIosTextLabelPlugin

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    
    //注册插件
    //注册 FlutterIosTextLabelFactory
    //com.flutter_to_native_test_textview 为flutter 调用此  textLabel 的标识
    [registrar registerViewFactory:[[FlutterIosTextLabelFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.flutter_to_native_test_textview"];
//     [registrar registerViewFactory:[[FlutterIosWebViewFactory alloc] initWithMessenger:registrar.messenger] withId:@"com.flutter_to_native_webview"];
}

@end
