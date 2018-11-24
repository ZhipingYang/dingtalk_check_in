//
//  BlackOverlayeView.m
//  DTKitDemo
//
//  Created by XcodeYang on 07/02/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import "BlackOverlayeView.h"
#import "ViewController.h"
#import "AppExtentsion.h"

@implementation BlackOverlayeView
{
	UILabel *label;
}

+ (BlackOverlayeView *)sharedInstance {
	static BlackOverlayeView *instance = nil;
	if (!instance) {
		instance = [[BlackOverlayeView alloc] init];
		instance.backgroundColor = [UIColor clearColor];
		instance.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		UIDevice *device = [UIDevice currentDevice];
		device.batteryMonitoringEnabled = YES;
		[[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(updateLabel) name:UIDeviceBatteryStateDidChangeNotification object:nil];

		UILabel *label = [[UILabel alloc] init];
		label.textColor = [UIColor clearColor];
		label.font = [UIFont boldSystemFontOfSize:30];
		label.textAlignment = NSTextAlignmentCenter;
		label.numberOfLines = 0;
		[instance addSubview:label];
		instance->label = label;
		
		UIWindow *window = [UIApplication sharedApplication].delegate.window;
		instance.frame = window.frame;
		[window addSubview:instance];
	}
	return instance;
}

+ (void)startAutoCover
{
	[NSObject cancelPreviousPerformRequestsWithTarget:[self sharedInstance]];
	[UIView animateWithDuration:0.3 animations:^{
		[self sharedInstance].backgroundColor = [UIColor clearColor];
		[self sharedInstance]->label.textColor = [UIColor clearColor];
	}];
	[[self sharedInstance] performSelector:@selector(show) withObject:[self sharedInstance] afterDelay:5];
}

+ (void)dismissCover
{
    [NSObject cancelPreviousPerformRequestsWithTarget:[self sharedInstance]];
    [self sharedInstance].backgroundColor = [UIColor clearColor];
    [self sharedInstance]->label.textColor = [UIColor clearColor];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	[[self class] startAutoCover];
	return nil;
}

- (void)show
{
	[UIView animateWithDuration:0.3 animations:^{
		self.backgroundColor = [UIColor blackColor];
	} completion:^(BOOL finished) {
		[self updateLabel];
	}];
	[[UIApplication sharedApplication].delegate.window endEditing:YES];
}


- (void)updateLabel
{
    BOOL isCharging = [UIDevice currentDevice].batteryState == UIDeviceBatteryStateCharging
                    || [UIDevice currentDevice].batteryState == UIDeviceBatteryStateFull;
    label.textColor = isCharging ? [UIColor colorWithWhite:0.1 alpha:1] : [UIColor colorWithRed:0.3 green:0 blue:0 alpha:1];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSInteger hour = [user integerForKey:dingdingOpenTimeHour];
    NSInteger minute = [user integerForKey:dingdingOpenTimeMinute];
    
    if (isCharging) {
        NSDate *date = [NSDate dateWithHour:hour minute:minute];
        NSString *tip = [date isLaterThan:[NSDate date]] ? @"今天" : @"明天";
        label.text = [NSString stringWithFormat:@"%@准时打卡\n%02zd:%02zd",tip,hour,minute];
    } else {
        label.text = [NSString stringWithFormat:@"以防关机,请接电源\n%02zd:%02zd",hour,minute];
    }
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	label.frame = self.bounds;
}

@end
