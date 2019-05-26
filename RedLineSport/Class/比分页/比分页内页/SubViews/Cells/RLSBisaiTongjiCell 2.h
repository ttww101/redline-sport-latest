#import <UIKit/UIKit.h>
#import "RLSLiveEventMedel.h"
@interface RLSBisaiTongjiCell : UITableViewCell
@property (nonatomic, strong) RLSLiveEventMedel *model;
-(void)tongjimmodel:(RLSLiveEventMedel*)model;
@end
