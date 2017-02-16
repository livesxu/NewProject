//
//  UITableViewCell+TableSimpleCell.m
//  XiaoLiuFisheries
//
//  Created by Livespro on 2017/2/10.
//  Copyright © 2017年 福中集团软件公司. All rights reserved.
//

#import "UITableViewCell+TableSimpleCell.h"
#import <objc/runtime.h>

@implementation UITableViewCell (TableSimpleCell)

- (void)setCellHeight_simple:(CGFloat)cellHeight_simple{
    
    objc_setAssociatedObject(self, @selector(cellHeight_simple), @(cellHeight_simple), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cellHeight_simple{
    
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}


- (void)setIndexPath_simple:(NSIndexPath *)indexPath_simple{
    
    objc_setAssociatedObject(self, @selector(indexPath_simple), indexPath_simple, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)indexPath_simple{
    
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setSimpleCellSelectedAction:(LXTableSimpleCellSelectedActionBlock)simpleCellSelectedAction{
    
    objc_setAssociatedObject(self, @selector(simpleCellSelectedAction), simpleCellSelectedAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LXTableSimpleCellSelectedActionBlock)simpleCellSelectedAction{
    
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setSimpleCellDeleteAction:(LXTableSimpleCellDeleteActionBlock)simpleCellDeleteAction{
    
    objc_setAssociatedObject(self, @selector(simpleCellDeleteAction), simpleCellDeleteAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LXTableSimpleCellDeleteActionBlock)simpleCellDeleteAction{
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
