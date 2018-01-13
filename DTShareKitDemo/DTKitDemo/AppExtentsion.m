//
//  AppExtentsion.m
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import "AppExtentsion.h"

// yyyy-M-dd HH:mm:ss

@implementation NSDate (AppExtentsion)

- (NSInteger)hour
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"HH";
	return [[formatter stringFromDate:self] integerValue];
}

- (NSInteger)minute
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"mm";
	return [[formatter stringFromDate:self] integerValue];
}

- (BOOL)isLaterThan:(NSDate *)date
{
	return self.timeIntervalSince1970 > date.timeIntervalSince1970;
}

- (NSDate *)getSchedualDate
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self];
	
	if ([self isLaterThan:[NSDate date]]) {
		// date的今天
		return self;
	} else {
		// date的明天
		[components setDay:components.day+1];
		return [calendar dateFromComponents:components];
	}
}

- (NSDate *)randomDateInSeconds:(NSInteger)seconds;
{
	if (seconds<=1) {
		return self;
	}
	return [NSDate dateWithTimeIntervalSince1970:self.timeIntervalSince1970 + arc4random()%(seconds)];
}

+ (NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute;
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
	[components setHour:hour];
	[components setMinute:minute];
	NSDate *dd = [calendar dateFromComponents:components];
	return dd;
}

- (NSString *)converChinese
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self];
	return [NSString stringWithFormat:@"%zd年%zd月%zd日 %zd时%zd分",components.year,components.month,components.day,components.hour,components.minute];
}
@end
