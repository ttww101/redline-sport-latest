#import <Foundation/Foundation.h>
@interface RLSAppConfig : NSObject
+ (instancetype)shareInstance;
- (void)initialize;
@end
