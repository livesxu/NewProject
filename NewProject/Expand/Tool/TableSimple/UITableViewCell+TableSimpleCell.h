//
//  UITableViewCell+TableSimpleCell.h
//  XiaoLiuFisheries
//
//  Created by Livespro on 2017/2/10.
//  Copyright © 2017年 福中集团软件公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LXTableSimpleCellSelectedActionBlock)(NSIndexPath *indexPath);

typedef void(^LXTableSimpleCellDeleteActionBlock)(NSIndexPath *indexPath);

@interface UITableViewCell (TableSimpleCell)

@property (nonatomic, assign) CGFloat cellHeight_simple;

@property (nonatomic, strong) NSIndexPath *indexPath_simple;

@property (nonatomic, copy) LXTableSimpleCellSelectedActionBlock simpleCellSelectedAction;

@property (nonatomic, copy) LXTableSimpleCellDeleteActionBlock simpleCellDeleteAction;

@end
