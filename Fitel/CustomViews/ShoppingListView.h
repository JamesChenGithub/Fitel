//
//  ShoppingListView.h
//  iLunch
//
//  Created by James on 15-1-10.
//  Copyright (c) 2015年 James Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingListView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    UIButton    *_back;
    UITableView *_tableView;
}

- (void)show;
- (void)dismiss;

@end
