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
    
    
//    __weak typeof(self) ws = self;
//    item = [[MenuItem alloc] initWithTitle:kSettingCell_CheckUpdate_Str icon:nil action:^(id<MenuAbleItem> menu) {
//        [ws checkVersion];
//    }];
//    [self.menuItems addObject:item];
//    
//    item = [[MenuItem alloc] initWithTitle:kSettingCell_ClearCache_Str icon:nil action:^(id<MenuAbleItem> menu) {
//        
//    }];
//    [self.menuItems addObject:item];
}

- (void)checkVersion
{
    
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *URL = @"http://itunes.apple.com/lookup?id=971774697";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    
    
    //    NSHTTPURLResponse *urlResponse = nil;
    //    NSError *error = nil;
    
    [[HUDHelper sharedInstance] loading];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *urlResponse, NSData *recervedData, NSError *connectionError) {
        
        [[HUDHelper sharedInstance] stopLoading];

        if (connectionError)
        {
            [[HUDHelper sharedInstance] tipMessage:kNetwork_Error_Str];
            return ;
        }
        
        NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [results objectFromJSONString];
        NSArray *infoArray = [dic objectForKey:@"results"];
        if ([infoArray count])
        {
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            
            if (![lastVersion isEqualToString:currentVersion] && [NSString isEmpty:lastVersion])
            {
                self.trackURL = [releaseInfo objectForKey:@"trackViewUrl"];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:kUpdate_Message_Str delegate:self cancelButtonTitle:kCancel_Str otherButtonTitles:kOK_Str, nil];
                [alert show];
            }
            else
            {
                [[HUDHelper sharedInstance] tipMessage:kUpdate_LatestVersion_Str];
            }
        }
        else
        {
            [[HUDHelper sharedInstance] tipMessage:kUpdate_LatestVersion_Str];
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackURL]];
    }
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
//        NSString *tempPath = [PathUtility getTemporaryPath];
//        NSString *video = [NSString stringWithFormat:@"%@/Video/", tempPath];
//        unsigned long long int size = [PathUtility folderSize:video];
//        
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%0.2fM", size / (1024*1024.0)];
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
