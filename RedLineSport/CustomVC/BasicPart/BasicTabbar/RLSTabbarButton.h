#import <UIKit/UIKit.h>
@interface RLSTabbarButton : UIButton
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, strong) NSString* deflut;
@property (nonatomic, strong) NSString* select;
@property (nonatomic, strong) UILabel * textLabel;
@property (nonatomic, strong) CALayer* flag;
- (void)setTabbarImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)titleStr;
@end
