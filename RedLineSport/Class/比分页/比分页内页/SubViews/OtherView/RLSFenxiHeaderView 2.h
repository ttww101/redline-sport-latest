@protocol FenxiHeaderViewDelegate <NSObject>

- (void)backClick:(NSInteger)btnTag;

- (void)tapPlayVideoAction:(NSString *)signal;

@end

#import <UIKit/UIKit.h>
#import "RLSLiveScoreModel.h"



@interface RLSFenxiHeaderView : UIView
@property (nonatomic, strong) UIButton *imageRight;
@property (nonatomic, weak)id<FenxiHeaderViewDelegate>delegate;
@property (nonatomic, strong) RLSLiveScoreModel *model;
- (void)hideBottom;
- (void)showBottom;
- (void)changeCountTimeWithTime:(NSString *)countTime;
- (void)updateScroeWithmodel:(RLSLiveScoreModel *)liviModel;
@end
