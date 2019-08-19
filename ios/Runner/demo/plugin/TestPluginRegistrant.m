//
//  TestPluginRegistrant.m
//  Runner
//
//  Created by  androidlongs on 2019/7/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "TestPluginRegistrant.h"
#import "FlutterNativePlugin.h"
#import "NativeFlutterPlugin.h"

@implementation TestPluginRegistrant
+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry{
   
    //注册插件
     [FlutterNativePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterNativePlugin"]];
//      [NativeFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"NativeFlutterPlugin"]];
    
//   FlutterViewController* controller = (FlutterViewController*) [UIApplication sharedApplication].keyWindow.rootViewController;
//    FlutterEventChannel* eventChannel = [FlutterEventChannel eventChannelWithName:@"com.native_to_flutter_test" binaryMessenger:controller];
//    [eventChannel setStreamHandler:registry];
    
}
@end
