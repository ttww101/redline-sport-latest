#import "RLSStatisticsSectionTwoTotalModel.h"
@implementation RLSStatisticsSectionTwoTotalModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"arrdxPanStatis" : @"dxPanStatis",
             @"arrouPanStatis" : @"ouPanStatis",
             @"arrplayStatis" : @"playStatis",
             @"arrsclassStatis" : @"sclassStatis",
             @"arrtimeStatis" : @"timeStatis",
             @"arryaPanStatis" : @"yaPanStatis",
             @"arryaChuanGuanStatis" : @"chuanGuanStatis",
             };
}
+ (NSValueTransformer *)arrdxPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arrouPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arrplayStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arrsclassStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arrtimeStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arryaPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)arryaChuanGuanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
@end
