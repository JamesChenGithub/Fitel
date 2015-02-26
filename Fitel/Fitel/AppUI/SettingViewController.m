//
//  SettingViewController.m
//  Fitel
//
//  Created by James on 2/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@property (nonatomic, strong) NSMutableArray *menuItems;

@end

@implementation SettingViewController;

- (void)viewDidLoad
{
    [self configOwnViews];
    [super viewDidLoad];
}

- (void)configOwnViews
{
    self.menuItems = [NSMutableArray array];
    
    MenuItem *item = [[MenuItem alloc] initWithTitle:kSettingCell_AboutUs_Str icon:nil action:^(id<MenuAbleItem> menu) {
        AboutUsViewController *vc = [[AboutUsViewController alloc] init];
        vc.title = [menu title];
        [[AppDelegate sharedAppDelegate] pushViewController:vc];
    }];
    [self.menuItems addObject:item];
    
    item = [[MenuItem alloc] initWithTitle:kSettingCell_OrderZone_Str icon:nil action:^(id<MenuAbleItem> menu) {
//        http://leeyihugh.pixnet.net/blog/post/261135124
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://leeyihugh.pixnet.net/blog/post/261135124"]];
    }];
    [self.menuItems addObject:item];
    
    item = [[MenuItem alloc] initWithTitle:kSettingCell_CheckUpdate_Str icon:nil action:^(id<MenuAbleItem> menu) {
        
    }];
    [self.menuItems addObject:item];
    
    item = [[MenuItem alloc] initWithTitle:kSettingCell_ClearCache_Str icon:nil action:^(id<MenuAbleItem> menu) {
        
    }];
    [self.menuItems addObject:item];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.menuItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kDefaultMargin/2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kDefaultMargin/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    MenuItem *item = [self.menuItems objectAtIndex:indexPath.section];
    cell.textLabel.text = item.title;
    
//    if (indexPath.section == self.menuItems.count - 1)
//    {
//        cell
//    }
//    else
//    {
//        cell.detailTextLabel.text = nil;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuItem *item = [self.menuItems objectAtIndex:indexPath.section];
    [item menuAction];
}

@end
