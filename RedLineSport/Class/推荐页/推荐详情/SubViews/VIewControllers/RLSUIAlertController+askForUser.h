#import <UIKit/UIKit.h>
@interface UIAlertController (askForUser)
+ (void)showWithtitle:(NSString *)title message:(NSString *)messege sure:(void(^)())sure;
+ (void)showWithtitle:(NSString *)title targrt:(id)target message:(NSString *)messege sure:(void(^)())sure;
+ (void)showWithtitle:(NSString *)title targrt:(id)target message:(NSString *)messege sureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancleTitle sure:(void(^)())sure cancle:(void(^)())cancle;
@end
