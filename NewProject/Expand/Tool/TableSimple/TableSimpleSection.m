//
//  TableSimpleSection.m
//  XiaoLiuFisheries
//
//  Created by Livespro on 2017/2/10.
//  Copyright © 2017年 福中集团软件公司. All rights reserved.
//

#import "TableSimpleSection.h"

@implementation TableSimpleSection

- (NSMutableArray *)cellsArray{
    if (!_cellsArray) {
        
        _cellsArray = [NSMutableArray array];
    }
    return _cellsArray;
}

- (void)addCell:(LXTableSimpleCellBlock)simpleCell;{
    
    UITableViewCell *cell_temp = simpleCell(_tableView,[NSIndexPath indexPathForRow:self.cellsArray.count inSection:_sectionIndex]);
    
    [self.cellsArray addObject:cell_temp];
   
}

@end
