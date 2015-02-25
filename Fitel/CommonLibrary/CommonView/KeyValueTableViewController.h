//
//  KeyValueTableViewController.h
//  iLunch
//
//  Created by James on 14-7-22.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import "BaseViewController.h"

@interface KeyValueTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
@protected
    NSMutableArray *_data;
    UITableView *_tableView;
}

@property (nonatomic, readonly) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;

- (void)configCell:(UITableViewCell *)cell with:(KeyValue *)kv;

@end

@interface OBDKeyValueTableViewController : KeyValueTableViewController

- (BOOL)isNormalAtIndexPath:(NSIndexPath *)indexPath;

@end
