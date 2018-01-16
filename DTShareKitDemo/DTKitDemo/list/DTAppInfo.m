//
//  DTAppInfo.m
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import "DTAppInfo.h"

static NSString *const NAME_KEY = @"localizedName";
static NSString *const APPID_KEY = @"applicationIdentifier";
static NSString *const TYPE_KEY = @"applicationType";
static NSString *const VERSION_KEY = @"shortVersionString";

@interface UIImage ()

+ (id)_applicationIconImageForBundleIdentifier:(NSString *)identifier format:(int)format scale:(double)scale;

@end

@interface DTAppInfo ()
{
	UIImage *_icon;
}

@property (nonatomic, strong, readwrite) id appProxy;

@end

@implementation DTAppInfo

- (instancetype)initWithProxy:(id)appProxy {
    self = [super init];
    if (self) {
        self.appProxy = appProxy;
    }
    return self;
}

- (NSString *)filterdata {
    NSString *_filterData = [NSString stringWithFormat:@"%@ %@",
                             [self objectForKeyedSubscript:NAME_KEY],
                             [self objectForKeyedSubscript:APPID_KEY]];
    return _filterData;
}

- (NSString *)name {
    return self[NAME_KEY];
}

- (NSString *)type {
    return self[TYPE_KEY];
}

- (NSString *)version {
    return self[VERSION_KEY];
}

- (UIImage *)icon {
    if (_icon == nil) {
		NSString *identifier = [self.appProxy performSelector:@selector(bundleIdentifier)];
        _icon = [UIImage _applicationIconImageForBundleIdentifier:identifier format:10 scale:2.0];
    }
    return _icon;
}

- (BOOL)isUserApp {
    return ([self.type isEqualToString:@"User"]);
}

#pragma mark - Custom Subscripting

- (id)objectForKeyedSubscript:(NSString *)key {
    NSString *description = [[self.appProxy valueForKey:key] description];
    if (!description) {
        description = @"(null)";
    }
    return description;
}

@end
