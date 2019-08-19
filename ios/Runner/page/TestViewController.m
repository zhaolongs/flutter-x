//
//  TestViewController.m
//  Runner
//
//  Created by  androidlongs on 2019/7/16.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "TestViewController.h"
#import "NativeFlutterPlugin.h"

@interface TestViewController ()<FlutterStreamHandler>

@end

@implementation TestViewController{
    
    FlutterEventSink _eventSink;
}

//退出页面
- (IBAction)backClickFunction:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)postFlutterMessage:(id)sender {
    NSLog(@"ios 主动调用 Flutter");
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInt:100] forKey:@"200"];
     [dict setObject:[NSNumber numberWithInt:100] forKey:@"content"];
    [dict setObject:@"ios 中成功" forKey:@"message"];
    
   // [NativeFlutterPlugin post:dict];
    
//    FlutterViewController* controller = (FlutterViewController*)self.view.window.rootViewController;
//    FlutterBasicMessageChannel* messageChannel2 = [FlutterBasicMessageChannel messageChannelWithName:@"com.native_to_flutter_test" binaryMessenger:controller];
//
//    // 发送消息
//    [messageChannel2 sendMessage:(dict) reply:^(id reply) {
//        NSLog(@" 回调 %@", reply);
//    }];
 
    
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
