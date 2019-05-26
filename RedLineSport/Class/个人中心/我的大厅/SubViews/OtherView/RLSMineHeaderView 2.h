#import <UIKit/UIKit.h>
@interface RLSMineHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic , strong) RLSUserModel *model;

@property (nonatomic , copy) NSDictionary *dic;


@end
