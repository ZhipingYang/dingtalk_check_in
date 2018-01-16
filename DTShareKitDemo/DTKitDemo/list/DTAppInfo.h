//
//  DTAppInfo.h
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTAppInfo : NSObject

@property (nonatomic, readonly) NSString *filterdata;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *version;
@property (nonatomic, readonly) BOOL isUserApp;

@property (nonatomic, readonly) UIImage *icon;

- (instancetype)initWithProxy:(id)appProxy;
- (id)objectForKeyedSubscript:(NSString *)key;

@end
