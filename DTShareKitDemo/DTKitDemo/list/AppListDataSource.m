//
//  AppListDataSource.m
//  DTShareKitDemo
//
//  Created by XcodeYang on 13/01/2018.
//  Copyright © 2018 QingShan. All rights reserved.
//

#import "AppListDataSource.h"
#import "DTAppInfo.h"

static NSString *const ALLAPPS_KEY = @"allapps";
static NSString *const SYSTEMAPPS_KEY = @"System";
static NSString *const USERAPPS_KEY = @"User";

NSInteger nameSort(DTAppInfo *app1, DTAppInfo *app2, void *context) {
	return [app1.name caseInsensitiveCompare:app2.name];
}

@interface AppListDataSource ()

@property (nonatomic, strong) NSDictionary <NSString *, NSArray *> *appsByCategory;
@property (nonatomic, strong) NSObject *workspace;

@end

@implementation AppListDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *apps = [self fetchApps];
        [self buildAppDictionary:apps];
    }
    return self;
}

- (NSArray *)fetchApps
{
	NSMutableArray *apps;
	Class LSApplicationWorkspace_class = NSClassFromString(@"LSApplicationWorkspace");
	
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
	self.workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
	apps = [self.workspace performSelector:@selector(allApplications)];
#pragma clang diagnostic pop
	
	return apps;
}

- (void)buildAppDictionary:(NSArray *)apps
{
	NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
	tempDictionary[ALLAPPS_KEY] = [NSMutableArray array];
	tempDictionary[SYSTEMAPPS_KEY] = [NSMutableArray array];
	tempDictionary[USERAPPS_KEY] = [NSMutableArray array];
	
	for (id app in apps) {
		DTAppInfo *appProxy = [[DTAppInfo alloc] initWithProxy:app];
		// TODO: what if category is not "User" or "System"?
		NSMutableArray *categoryList = tempDictionary[appProxy.type];
		[tempDictionary[ALLAPPS_KEY] addObject:appProxy];
		[categoryList addObject:appProxy];
	}
	
	self.appsByCategory = @{
							ALLAPPS_KEY : [tempDictionary[ALLAPPS_KEY] sortedArrayUsingFunction:nameSort context:NULL],
							SYSTEMAPPS_KEY : [tempDictionary[SYSTEMAPPS_KEY] sortedArrayUsingFunction:nameSort context:NULL],
							USERAPPS_KEY : [tempDictionary[USERAPPS_KEY] sortedArrayUsingFunction:nameSort context:NULL]
							};
}

#pragma mark - Custom Subscripting

- (id)objectAtIndexedSubscript:(NSInteger)idx
{
    return self.appsByCategory[ALLAPPS_KEY][idx];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.appsByCategory[ALLAPPS_KEY].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const CELL_IDENTIFIER = @"AppCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
	}
    DTAppInfo *app = self.appsByCategory[ALLAPPS_KEY][indexPath.row];

	cell.textLabel.textColor = app.isUserApp ? [UIColor redColor] : [UIColor blackColor];
    cell.textLabel.text = app.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = app.icon;
    return cell;
}

- (void)openApp:(NSString *)bundleID
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
  [self.workspace performSelector:@selector(openApplicationWithBundleID:) withObject:bundleID];
#pragma clang diagnostic pop
}

@end
