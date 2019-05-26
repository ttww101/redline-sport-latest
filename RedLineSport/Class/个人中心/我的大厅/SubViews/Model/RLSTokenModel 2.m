#import "RLSTokenModel.h"
@implementation RLSTokenModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"refreshToken" : @"refreshToken",
             @"token" : @"token",
             };
}
@end
