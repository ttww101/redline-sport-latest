#import "RLSBaolengDetailModel.h"
@implementation RLSBaolengDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"body" : @"body" ,
             @"list" : @"list" ,
             };
}
+ (NSValueTransformer *)bodyJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSBaolengDTModel class]];
}
+ (NSValueTransformer *)listJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSBaolengMatchModel class]];
}
@end
