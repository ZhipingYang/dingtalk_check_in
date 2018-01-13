//
//  HistoryController.m
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import "HistoryController.h"

#define HistoryRecords @"HistoryRecords"

@interface HistoryController ()

@property (nonatomic, strong) NSArray <NSString *> *history;

@end

@implementation HistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
	_history = [[NSUserDefaults standardUserDefaults] objectForKey:@"HistoryRecords"] ?: @[];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (IBAction)cleanAction:(UIBarButtonItem *)sender {
	[[NSUserDefaults standardUserDefaults] setObject:@[] forKey:@"HistoryRecords"];
	_history = @[];
	[self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _history.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
	cell.textLabel.text = [_history objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
