//
//  TableRefreshViewController.m
//  iLunch
//
//  Created by James on 15-2-5.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import "TableRefreshViewController.h"

@implementation TableRefreshViewController

- (void)initialize
{
    [super initialize];
    _clearsSelectionOnViewWillAppear = YES;
}

- (void)addRefreshScrollView
{
    _tableView = [[UITableView alloc] init];
    _tableView.frame = self.view.bounds;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.refreshScrollView = _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_tableView)
    {
        NSIndexPath *selected = [_tableView indexPathForSelectedRow];
        if (selected)
        {
            [_tableView deselectRowAtIndexPath:selected animated:animated];
        }
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
@end
