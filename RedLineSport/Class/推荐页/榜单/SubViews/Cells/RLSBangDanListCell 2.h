#import <UIKit/UIKit.h>
#import "RLSRecommandListModel.h"
@interface RLSBangDanListCell : UITableViewCell
@property (nonatomic, assign)NSInteger cellNum;
@property (nonatomic, strong)RLSRecommandListModel  *model;
@property (nonatomic, assign)NSInteger type;
@end
