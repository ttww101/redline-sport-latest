#import "RLSTongpeiDTModel.h"
@implementation RLSTongpeiDTModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"same" : @"same",
             @"all" : @"all",
             };
}
+ (NSValueTransformer *)sameJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSTongpeiDetailModel class]];
}
+ (NSValueTransformer *)allJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSTongpeiDetailModel class]];
}
@end
