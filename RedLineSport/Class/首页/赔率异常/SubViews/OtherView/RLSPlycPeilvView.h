#import <UIKit/UIKit.h>
@protocol PlycPeilvViewdelegate<NSObject>
@optional
- (void)didselePlycPeilvViewWithIndex:(NSInteger)index;
- (void)touchPlycPeilvViewBgView;
@end
@interface RLSPlycPeilvView : UIView
@property (nonatomic,weak) id<PlycPeilvViewdelegate> delegate;
@end
