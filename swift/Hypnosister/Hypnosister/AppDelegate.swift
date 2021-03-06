//
//  AppDelegate.swift
//  Hypnosister
//
//  Created by Omer Wazir on 8/4/14.
//  Copyright (c) 2014 Omer Wazir. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIScrollViewDelegate {
                            
    var window: UIWindow?
    
    var hypnosisView:HypnosisView?
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return self.hypnosisView;
    }

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        
        //not sure why window is an optional type. When could it not get initialized?
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds);
        
        //Create CGRects for frames
        var screenRect:CGRect = self.window!.bounds;
        
        //create a screen sized scroll view and add it to the window
        let scrollView:UIScrollView = UIScrollView(frame: screenRect);
        scrollView.pagingEnabled = false;
        scrollView.maximumZoomScale = 6.0;
        scrollView.delegate = self;
        scrollView.contentSize = screenRect.size;
        
        self.window!.addSubview(scrollView);
        
        //create a screen–sized hypnosis view and add it to the scroll view
        self.hypnosisView = HypnosisView(frame: screenRect);
        scrollView.addSubview(hypnosisView!);
        
        
        self.window!.backgroundColor = UIColor.whiteColor();
        self.window!.makeKeyAndVisible();
        
        return true
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

