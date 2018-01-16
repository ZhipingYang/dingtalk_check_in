//
//  AppListController.m
//  DTKitDemo
//
//  Created by XcodeYang on 16/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import "AppListController.h"
#import "AppListDataSource.h"
#import "DTAppInfo.h"

@interface AppListController ()<UITableViewDelegate>

@property (nonatomic, strong) AppListDataSource *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AppListController

- (void)viewDidLoad {
    [super viewDidLoad];
	_dataSource = [[AppListDataSource alloc] init];
	_tableView.dataSource = _dataSource;
	_tableView.delegate = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	DTAppInfo *object = [_dataSource objectAtIndexedSubscript:indexPath.row];
	[_dataSource openApp:object[@"bundleIdentifier"]];
}

@end
