#import "RLSJSbifenModel.h"
@implementation RLSJSbifenModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time",
             @"data" : @"items",
             @"label" : @"label"
             };
}
+ (NSValueTransformer *)dataJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSLiveScoreModel class]];
}
@end
