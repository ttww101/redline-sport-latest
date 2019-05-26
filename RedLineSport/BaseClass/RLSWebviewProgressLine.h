#import <UIKit/UIKit.h>
@interface RLSWebviewProgressLine : UIView
@property (nonatomic,strong) UIColor  *lineColor;
-(void)startLoadingAnimation;
-(void)endLoadingAnimation;
@end
