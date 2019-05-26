#import "RLSUserTongjiAllModel.h"
@implementation RLSUserTongjiAllModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"month" : @"month",
             @"all" : @"all",
             @"week" : @"week",
             @"recent" : @"recent",
             };
}
+ (NSValueTransformer *)monthJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSUserTongjiModel class]];
}
+ (NSValueTransformer *)allJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSUserTongjiModel class]];
}
+ (NSValueTransformer *)weekJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSUserTongjiModel class]];
}
@end
