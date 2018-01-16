//
//  AppListDataSource.h
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppListDataSource : NSObject <UITableViewDataSource>

- (id)objectAtIndexedSubscript:(NSInteger)idx;

- (void)openApp:(NSString *)bundleID;

@end
