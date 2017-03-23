// Static Table 创建，cell最好不要复用 ->当section.cellsArray总量大于reusableCells则多于部分无法显示！

#import <UIKit/UIKit.h>
#import "TableSimpleSection.h"
#import "UITableViewCell+TableSimpleCell.h"

typedef void(^LXTableSimpleSectionBlock)(TableSimpleSection *section,NSUInteger sectionIndex);

@interface TableViewSimple : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sectionsArray;

- (void)addSection:(LXTableSimpleSectionBlock)sectionBlock;

- (void)simpleInsertIndex:(NSUInteger)sectionIndex Section:(LXTableSimpleSectionBlock)sectionBlock;

- (void)simpleInsertIndexPath:(NSIndexPath *)cellPath Cell:(LXTableSimpleCellBlock)simpleCell;

- (void)simpleDeleteSections:(NSIndexSet *)sections
            withRowAnimation:(UITableViewRowAnimation)animation;

- (void)simpleDeleteRowsAtIndexPath:(NSIndexPath *)indexPath
                   withRowAnimation:(UITableViewRowAnimation)animation;

@end
