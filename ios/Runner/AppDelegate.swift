import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
        
    
     
        
        //        self.window = UIWindow(frame: UIScreen.main.bounds)
        //        //        把初始视图控制器压入导航视图控制器
        //        let navigationController = UINavigationController(rootViewController: FlutterViewController());
        //        //        把根视图控制器设为导航视图控制器
        //        self.window?.rootViewController = navigationController
        //        //        渲染出页面
        //        self.window?.makeKeyAndVisible()
        
        
        
        //flutter 中引用的插件通过些类来注册
        GeneratedPluginRegistrant.register(with: self);
        //注册自定义插件
//        TestPluginRegistrant.register(with: self);
//
//        //注册插件
//        FlutterIosTextLabelRegistran.register(with: self);
//
        
        //        return true;
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    
}


