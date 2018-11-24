//
//  ViewController.m
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import "ViewController.h"
#import "AppExtentsion.h"
#import <DTShareKit/DTOpenKit.h>
#import "BlackOverlayeView.h"

@interface ViewController ()<UITextFieldDelegate>
{
	NSInteger _hour;
	NSInteger _minute;
}
@property (weak, nonatomic) IBOutlet UISwitch *isInstalledSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dailyTime;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self configDate];
    [BlackOverlayeView startAutoCover];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [BlackOverlayeView dismissCover];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_isInstalledSwitch.on = [DTOpenAPI isDingTalkInstalled];
    [self configDate];
}

- (void)configDate
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL hadEntered = [user boolForKey:appHadBeenEntered];
    
    if (hadEntered) {
        _hour = [user integerForKey:dingdingOpenTimeHour];
        _minute = [user integerForKey:dingdingOpenTimeMinute];
        _datePicker.date = [NSDate dateWithHour:_hour minute:_minute];
        
    } else {
        [user setBool:YES forKey:appHadBeenEntered];
        _hour = self.datePicker.date.hour;
        _minute = self.datePicker.date.minute;
        [user setInteger:_hour forKey:dingdingOpenTimeHour];
        [user setInteger:_minute forKey:dingdingOpenTimeMinute];
        [user synchronize];
    }
    [self updateTimeLabel];
    [self scheduleNotification];
}

#pragma mark - private

- (void)updateTimeLabel
{
	NSString *tip = [_datePicker.date isLaterThan:[NSDate date]] ? @"今天" : @"明天";
	self.dailyTime.text = [NSString stringWithFormat:@"%@ - %02zd:%02zd", tip, _hour, _minute];
}

- (void)scheduleNotification
{
	UIApplication *application = [UIApplication sharedApplication];
	
	[application cancelAllLocalNotifications];
	
	UILocalNotification* localNotification = [[UILocalNotification alloc] init];
	localNotification.timeZone = [NSTimeZone localTimeZone];
	localNotification.fireDate = [[_datePicker.date getSchedualDate] randomDateInSeconds:_textfield.text.integerValue];
    if (@available(iOS 8.2, *)) {
        localNotification.alertTitle = @"🌚😂🌚🤣🌚😏🌚";
        localNotification.alertBody = @"当你此消息，说明你还没有自动打卡！,要是来得及？点我补救吧，少年！！";
    }
	localNotification.soundName = UILocalNotificationDefaultSoundName;
	localNotification.applicationIconBadgeNumber = 1;
	
	if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge
                                                | UIUserNotificationTypeSound 
                                                | UIUserNotificationTypeAlert categories:nil];
        [application registerUserNotificationSettings:settings];
	}
	
	[application scheduleLocalNotification:localNotification];
}

#pragma mark - events

- (IBAction)openDingTalk:(UIButton *)sender
{
	[DTOpenAPI openDingTalk];
}

- (IBAction)datePickerChanged:(UIDatePicker *)sender
{
	NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
	_hour = sender.date.hour;
	_minute = sender.date.minute;
	[user setInteger:_hour forKey:dingdingOpenTimeHour];
	[user setInteger:_minute forKey:dingdingOpenTimeMinute];
	[user synchronize];
	[self updateTimeLabel];
	[self scheduleNotification];
}

#pragma mark - delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[self scheduleNotification];
}

@end

