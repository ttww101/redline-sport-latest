#import "RLSPanwangCollectCell.h"
#import "RLSPanwangZhishuTable.h"
@interface RLSPanwangCollectCell()
@property (nonatomic, strong) RLSPanwangZhishuTable *table;
@end
@implementation RLSPanwangCollectCell
- (void)setType:(NSString *)type
{
    _type = type;
    [self.contentView addSubview:self.table];
    _table.type = _type;
}
- (RLSPanwangZhishuTable *)table
{
    if (!_table) {
        _table = [[RLSPanwangZhishuTable alloc] initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _table;
}
@end
