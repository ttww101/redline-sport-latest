#import <UIKit/UIKit.h>
#import "RLSPanWangModel.h"
@interface RLSPanwangCell : UITableViewCell
@property (nonatomic, strong)UILabel *labGaiLv;
@property (nonatomic, strong)UILabel *labGaiLvTitle;
@property (nonatomic, assign)NSInteger rankNum;
@property (nonatomic, strong)RLSPanWangModel *model;
@end
