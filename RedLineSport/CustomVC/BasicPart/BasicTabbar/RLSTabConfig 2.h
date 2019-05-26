#import <Foundation/Foundation.h>
#import "RLSDCTabBarController.h"
@interface RLSTabConfig : NSObject
@property (nonatomic, readonly, strong) RLSDCTabBarController *tabBarController;
@property (nonatomic, copy) NSString *currentPage;
@end
