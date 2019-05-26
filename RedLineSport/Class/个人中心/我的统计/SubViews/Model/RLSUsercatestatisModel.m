#import "RLSUsercatestatisModel.h"
@implementation RLSUsercatestatisModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"avgweeknum" : @"avgweeknum",
             @"userinfo" : @"userinfo",
             @"goodplay" : @"goodplay",
             @"goodsclass" : @"goodsclass",
             @"totalrate" : @"totalrate",
             @"nearten" : @"nearten",
             @"sclassStatis" : @"sclassStatis",
             @"playStatis0" : @"playAllStatis",
             @"playStatis1" : @"playOuStatis",
             @"playStatis2" : @"playYaStatis",
             @"playStatis3" : @"playDxStatis",
             @"yaPanStatis" : @"yaPanStatis",
             @"ouPanStatis" : @"ouPanStatis",
             @"dxPanStatis" : @"dxPanStatis",
             @"timeStatis" : @"timeStatis",
             @"monthGroup" : @"groupTimeMonthStatis",
             @"weekGroup" : @"groupTimeWeekStatis",
             };
}
+ (NSValueTransformer *)userinfoJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSStatisticsModel class]];
}
+ (NSValueTransformer *)goodplayJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSGoodPlayModel class]];
}
+ (NSValueTransformer *)goodsclassJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSGoodsclassModel class]];
}
+ (NSValueTransformer *)totalrateJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSTotalrateModel class]];
}
+ (NSValueTransformer *)sclassStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)playStatis0JSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)playStatis1JSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)playStatis2JSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)playStatis3JSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)yaPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)ouPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)dxPanStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)timeStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)monthGroupJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
+ (NSValueTransformer *)weekGroupJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSStatisticsSectionTwoModel class]];
}
@end
