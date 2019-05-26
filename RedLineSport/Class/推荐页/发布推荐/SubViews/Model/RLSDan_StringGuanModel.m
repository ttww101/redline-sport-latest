#import "RLSDan_StringGuanModel.h"
@implementation RLSDan_StringGuanModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"count" : @"count",
             @"index" : @"index",
             @"matchs":@"matchs",
             };
}
+ (NSValueTransformer *)matchsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSDan_StringMatchsModel class]];
}
@end
