#import <UIKit/UIKit.h>
@protocol VierticalScrollViewDelegate <NSObject>
@optional
-(void)clickTitleButton:(UIButton *)button;
@end
@interface RLSVierticalScrollView : UIView
@property (nonatomic,strong) id<VierticalScrollViewDelegate> delegate;
-(instancetype)initWithArray:(NSArray *)titles AndFrame:(CGRect)frame;
+(instancetype)initWithTitleArray:(NSArray *)titles AndFrame:(CGRect)frame;
@end
