#import <UIKit/UIKit.h>
#import "RLSDxModel.h"
@protocol SelectedViewOfFabuTuijianDelegate <NSObject>
@optional
- (void)didselectedAtIndex:(NSInteger)index WithModel:(RLSDxModel *)selectedModel WithCompanyIndex:(NSInteger)companyIndex;
@end
@interface RLSSelectedViewOfFabuTuijian : UIView
@property (nonatomic, assign)NSInteger newTypeNum;
@property (nonatomic, assign)NSInteger companyIndex;
@property (nonatomic, strong) RLSDxModel *model;
@property (nonatomic, weak) id<SelectedViewOfFabuTuijianDelegate> delegate;
- (void)clearbackGroundImage;
- (void)setCurrentIndex:(NSInteger )index;
@end
