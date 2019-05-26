#import <UIKit/UIKit.h>
UIKIT_EXTERN NSString *const PayMentLeftIcon;
UIKIT_EXTERN NSString *const PayMentTitle;
UIKIT_EXTERN NSString *const PayMentType;
UIKIT_EXTERN NSString *const CouponCount;
@protocol OptionViewDelegate;
@interface RLSOptionView : UIView
@property (nonatomic, weak) id <OptionViewDelegate> deleate;
- (instancetype)initWithFrame:(CGRect)frame  configDictionary:(NSDictionary *)dic;
- (void)hideBottormLine;
@end
@protocol OptionViewDelegate <NSObject>
- (void)didSelectAction:(UIButton *)sender;
@end
