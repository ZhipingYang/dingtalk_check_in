//
//  AppExtentsion.h
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AppExtentsion)

- (NSInteger)hour;

- (NSInteger)minute;

- (BOOL)isLaterThan:(NSDate *)date;

// 获取正确是打卡时间（要和当前时间对比）
- (NSDate *)getSchedualDate;

+ (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute;

// 允许自动打卡前后误差
- (NSDate *)randomDateInSeconds:(NSInteger)seconds;

- (NSString *)converChinese;

@end
