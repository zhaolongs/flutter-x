//
//  FlutterNativePlugin.m
//  Runner
//
//  Created by  androidlongs on 2019/7/15.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "FlutterNativePlugin.h"
#import "TestViewController.h"

@implementation FlutterNativePlugin


//实现方法registrar来注册插件
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    //注册与flutter的通道
    FlutterMethodChannel* channel =
    [FlutterMethodChannel methodChannelWithName:@"com.flutter_to_native_test"
                                binaryMessenger:[registrar messenger]];
    //初始化插件 FlutterNativePlugin
    FlutterNativePlugin* instance = [[FlutterNativePlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    
    
    
    
    
}

//flutter 调用ios 平台的回调方法
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

    //获取flutter中 设置method
    //也就是 TestInteractNative.goNativeWithValue("register") 中的 register
    NSString *method = call.method;
    NSLog(@"FlutterMethodCall-->%@",method);
    
    //获取 flutter 中传递的参数
    NSDictionary *arguments= call.arguments;
    //获取所有的key
    NSArray * keyArray  =  [arguments allKeys];

    for (int i=0; i<keyArray.count; i++) {
        //获取key
        NSString *key = [keyArray objectAtIndex:i];
        //获取value
        NSString *value=arguments[key];
        NSLog(@"flutter 传递参数 [key:%@ value:%@]",key,value);
    }
    /**
     * 在这里就可以处理IOS 方面的逻辑需要了，比如调用  扫一扫、相机 、录音、权限申请、Activity页面等等
     * 然后再通过 result 回调 flutter 中
     */
    if([method isEqualToString:@"openAndroidActivity"]){
        
        //打开新的页面
        TestViewController *testController =[[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
    
      
    
        
        FlutterViewController* controller = (FlutterViewController*) [UIApplication sharedApplication].keyWindow.rootViewController;
        [controller presentModalViewController:testController animated:YES];
       
    }
    result(@"ios 平台方法调用成功");
   
    
}

@end
