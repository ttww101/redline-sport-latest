#import <Foundation/Foundation.h>
#import "RLSUserModel.h"
typedef void(^requestStart)(id requestOrignal);
typedef void (^UserInfo)(RLSUserModel* user);
@interface RLSUniversalNetwork : NSObject
+ (void)getUserModelWithUserId:(NSInteger)Idid WithUserModel:(UserInfo)user;
+ (void)getUserWithUserId:(NSInteger)Idid WithUserModel:(void(^)(RLSUserModel* useInfo))user;
@end
