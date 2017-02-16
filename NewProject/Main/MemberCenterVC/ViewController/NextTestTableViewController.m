//
//  NextTestTableViewController.m
//  NewProject
//
//  Created by Livespro on 2016/12/22.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "NextTestTableViewController.h"

@interface NextTestTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation NextTestTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
   
    [self.view addSubview:_tableView];
    
    
    [_tableView addSection:^(TableSimpleSection *section, NSUInteger sectionIndex) {
        
        section.headerHeight = 10;
        
        UIView *header =  [[UIView alloc]init];
        header.backgroundColor = [UIColor redColor];
        
        section.headerView = header;
        
        UIView *footer =  [[UIView alloc]init];
        footer.backgroundColor = [UIColor yellowColor];
        
        section.footerHeight = 20;
        
        section.footerView = footer;
        
        [section addCell:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            
            UITableViewCell *cell = [[UITableViewCell alloc]init];
            
            cell.cellHeight_simple = 50;
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            return cell;
            
        }];
    }];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *cellText = nil;
    if (indexPath.row%10 == 0)
    {
        usleep(200*1000);
        cellText = @"我需要一些时间";
    }else
    {
        cellText = [NSString stringWithFormat:@"cell%ld",indexPath.row];
    }
    
    cell.textLabel.text = cellText;
    return cell;
}

@end
