#import "RLSUserlistModel.h"
@implementation RLSUserlistModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"nickname" : @"nickname",
             @"pic" : @"pic",
             @"remark" : @"remark",
             @"userid" : @"id",
             @"userintro" : @"userintro",
             @"newRecommendCount" : @"newRecommendCount",
             };
}
@end
