//
//  AppDelegate.m
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import "AppDelegate.h"
#import "AppExtentsion.h"
#import <DTShareKit/DTOpenKit.h>

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 注册AppId;
    [DTOpenAPI registerApp:@"dingoak5hqhuvmpfhpnjvt"];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    //    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray <NSString *> *history = [user objectForKey:@"HistoryRecords"] ?: @[];
    NSMutableArray *newHistory = history.mutableCopy;
    [newHistory insertObject:[[NSDate date] converChinese] atIndex:0];
    [user setObject:[NSArray arrayWithArray:newHistory] forKey:@"HistoryRecords"];
    [user synchronize];
    
    [DTOpenAPI openDingTalk];
}

@end
