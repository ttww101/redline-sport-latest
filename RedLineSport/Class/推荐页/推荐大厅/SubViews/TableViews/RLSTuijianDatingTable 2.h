#import "RLSBasicTableView.h"
@interface RLSTuijianDatingTable : RLSBasicTableView
@property (nonatomic, assign) NSInteger playType;
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style playType:(NSInteger)type;
- (void)addSelectedView;
@end
