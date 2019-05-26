#import "RLSFansModel.h"
@implementation RLSFansModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"idId" : @"id",
             @"recommend_count" : @"recommend_count",
             @"nickname" : @"nickname",
             @"follower_count" : @"follower_count",
             @"info_count" : @"info_count",
             @"pic" : @"pic",
             @"focus_count" : @"focus_count",
             @"focused" : @"focused",
             };
}
@end
