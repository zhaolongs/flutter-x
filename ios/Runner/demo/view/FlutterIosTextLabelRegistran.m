//
//  FlutterIosTextLabelRegistran.m
//  Runner
//
//  Created by  androidlongs on 2019/7/16.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "FlutterIosTextLabelRegistran.h"

@implementation FlutterIosTextLabelRegistran

+(void)registerWithRegistry:(NSObject<FlutterPluginRegistry> *)registry{
    //注册插件
    [FlutterIosTextLabelPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterIosTextLabelPlugin"]];
}

@end
