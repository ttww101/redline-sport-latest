#import <UIKit/UIKit.h>
@protocol TopContentViewDelegate <NSObject>
- (void)addAtention:(BOOL)attention;
@end
@interface RLSTopContentView : UIView
@property (nonatomic , strong) RLSUserModel *model;
@property (nonatomic, weak) id <TopContentViewDelegate> delegate;
@end
