//
//  TableSimpleSection.h
//  XiaoLiuFisheries
//
//  Created by Livespro on 2017/2/10.
//  Copyright © 2017年 福中集团软件公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef UITableViewCell*(^LXTableSimpleCellBlock)(UITableView *tableView,NSIndexPath *indexPath);

@interface TableSimpleSection : NSObject

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong) NSMutableArray *cellsArray;//cells数组 --- 存放cell实体，适用static页面

@property (nonatomic, assign) NSInteger sectionIndex;

- (void)addCell:(LXTableSimpleCellBlock)simpleCell;

@end
