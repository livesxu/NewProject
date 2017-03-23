//
//  TableViewSimple.m
//  XiaoLiuFisheries
//
//  Created by Livespro on 2017/3/9.
//  Copyright © 2017年 福中集团软件公司. All rights reserved.
//

#import "TableViewSimple.h"

@implementation TableViewSimple

- (void)addSection:(LXTableSimpleSectionBlock)sectionBlock;{
    
    if (!self.sectionsArray) {
        
        self.sectionsArray = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    TableSimpleSection *section = [[TableSimpleSection alloc]init];
    
    section.tableView = self;
    
    section.sectionIndex = self.sectionsArray.count;
    
    sectionBlock(section,section.sectionIndex);
    
    [self.sectionsArray addObject:section];
    
}

- (void)simpleInsertIndex:(NSUInteger)sectionIndex Section:(LXTableSimpleSectionBlock)sectionBlock;{
    
    if (!self.sectionsArray) {
        
        self.sectionsArray = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        
    }
    
    TableSimpleSection *section = [[TableSimpleSection alloc]init];
    
    section.tableView = self;
    
    section.sectionIndex = sectionIndex;
    
    sectionBlock(section,section.sectionIndex);
    
    [self beginUpdates];
    
    [self.sectionsArray insertObject:section atIndex:sectionIndex];
    
    [self insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
    
    [self endUpdates];
}

- (void)simpleInsertIndexPath:(NSIndexPath *)cellPath Cell:(LXTableSimpleCellBlock)simpleCell;{
    
    UITableViewCell *cell_temp = simpleCell(self,cellPath);
    
    [self beginUpdates];
    
    TableSimpleSection *section_temp = self.sectionsArray[cellPath.section];
    
    [section_temp.cellsArray insertObject:cell_temp atIndex:cellPath.row];
    
    [self insertRowsAtIndexPaths:@[cellPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self endUpdates];
}

- (void)simpleDeleteSections:(NSIndexSet *)sections
            withRowAnimation:(UITableViewRowAnimation)animation;{
    
    [self beginUpdates];
    
    [self.sectionsArray removeObjectsAtIndexes:sections];
    
    [self deleteSections:sections  withRowAnimation:animation];
    
    [self endUpdates];
    
}

- (void)simpleDeleteRowsAtIndexPath:(NSIndexPath *)indexPath
                   withRowAnimation:(UITableViewRowAnimation)animation;{
    
    [self beginUpdates];
    
    TableSimpleSection *section_temp = self.sectionsArray[indexPath.section];
    
    [section_temp.cellsArray removeObjectAtIndex:indexPath.row];
    
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    
    [self endUpdates];
    
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    
    TableSimpleSection *section_temp = self.sectionsArray[section];
    
    section_temp.sectionIndex = section;
    
    return section_temp.cellsArray.count;
}

#pragma mark - cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    TableSimpleSection *section_temp = self.sectionsArray[indexPath.section];
    
    UITableViewCell *cell_temp = section_temp.cellsArray[indexPath.row];
    
    cell_temp.indexPath_simple = indexPath;
    
    return cell_temp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableSimpleSection *section_temp = self.sectionsArray[indexPath.section];
    
    UITableViewCell *cell_temp = section_temp.cellsArray[indexPath.row];
    
    return cell_temp.cellHeight_simple;
}

#pragma mark - header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TableSimpleSection *section_temp = self.sectionsArray[section];
    
    return section_temp.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    TableSimpleSection *section_temp = self.sectionsArray[section];
    
    return section_temp.headerHeight;
}

#pragma mark - footer
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    TableSimpleSection *section_temp = self.sectionsArray[section];
    
    return section_temp.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    TableSimpleSection *section_temp = self.sectionsArray[section];
    
    return section_temp.footerHeight;
}

#pragma mark - selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableSimpleSection *section_temp = self.sectionsArray[indexPath.section];
    
    UITableViewCell *cell_temp = section_temp.cellsArray[indexPath.row];
    
    if (cell_temp.simpleCellSelectedAction) {
        
        cell_temp.simpleCellSelectedAction(indexPath);
        
    }
}

#pragma mark - delete

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableSimpleSection *section_temp = self.sectionsArray[indexPath.section];
    
    UITableViewCell *cell_temp = section_temp.cellsArray[indexPath.row];
    
    return cell_temp.simpleCellDeleteAction ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        TableSimpleSection *section_temp = self.sectionsArray[indexPath.section];
        
        UITableViewCell *cell_temp = section_temp.cellsArray[indexPath.row];
        
        if (cell_temp.simpleCellDeleteAction) {
            
            cell_temp.simpleCellDeleteAction(indexPath);
            
        }
    }
}

@end
