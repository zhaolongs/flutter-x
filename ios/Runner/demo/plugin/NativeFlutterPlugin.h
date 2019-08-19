//
//  NativeFlutterPlugin.h
//  Runner
//
//  Created by  androidlongs on 2019/7/16.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
NS_ASSUME_NONNULL_BEGIN

@interface NativeFlutterPlugin : NSObject<FlutterPlugin>
+(void)post:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
