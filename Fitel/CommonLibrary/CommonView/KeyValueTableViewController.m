//
//  KeyValueTableViewController.m
//  iLunch
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "KeyValueTableViewController.h"

@interface KeyValueTableViewController ()

@end

@implementation KeyValueTableViewController

- (void)addOwnViews
{
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = kDefaultCellHeight;
    
    [self.view addSubview:_tableView];
}

- (void)layoutOnIPhone
{
    _tableView.frame = self.view.bounds;
}

#define kWTATableCellIdentifier  @"WTATableCellIdentifier"

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (void)configCell:(UITableViewCell *)cell with:(KeyValue *)kv
{
    cell.textLabel.text = kv.key;
    cell.detailTextLabel.text = [kv.value description];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWTATableCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kWTATableCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = kMainTextColor;
        cell.detailTextLabel.textColor = kMainTextColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    KeyValue *kv = _data[indexPath.row];
    [self configCell:cell with:kv];
    return cell;
}

@end

@implementation OBDKeyValueTableViewController

- (BOOL)isNormalAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    BOOL isNorma = [self isNormalAtIndexPath:indexPath];
    
    cell.textLabel.textColor = isNorma ? kBlackColor : kRedColor;
    cell.detailTextLabel.textColor = isNorma ? kBlackColor : kRedColor;
    
    cell.backgroundColor = indexPath.row % 2 ? kWhiteColor : RGB(240, 240, 240);
    return cell;
}

@end
