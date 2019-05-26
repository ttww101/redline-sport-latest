#import <UIKit/UIKit.h>
#import "RLSUserlistModel.h"
@protocol FirstPUserlistViewDelegate <NSObject>
@optional
- (void)selectedUserWithId:(RLSUserlistModel *)user;
@end
@interface RLSFirstPUserlistView : UIView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, weak) id<FirstPUserlistViewDelegate> delegate;
@end
