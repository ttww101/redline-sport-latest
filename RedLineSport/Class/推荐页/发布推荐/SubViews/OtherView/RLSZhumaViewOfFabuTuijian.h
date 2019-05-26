#import <UIKit/UIKit.h>
#import "RLSPriceListModel.h"
@protocol ZhumaViewOfFabuTuijianDelegate<NSObject>
@optional
- (void)didselectedZhumaAtIndex:(NSInteger)index;
- (void)didselectedPriceViewWithModel:(RLSPriceListModel *)price;
@end
@interface RLSZhumaViewOfFabuTuijian : UIView
@property (nonatomic, weak) id<ZhumaViewOfFabuTuijianDelegate> delegate;
@property (nonatomic, strong) NSArray *priceList;
@end
