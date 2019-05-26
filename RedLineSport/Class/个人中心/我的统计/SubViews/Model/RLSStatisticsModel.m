#import "RLSUsermarkModel.h"
#import "RLSMedalsModel.h"
#import "RLSStatisticsModel.h"
@implementation RLSStatisticsModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"avgweeknum" : @"avgweeknum",
             @"focus_count" : @"focus_count",
             @"follower_count" : @"follower_count",
             @"gonum" : @"gonum",
             @"idId" : @"id",
             @"level_id" : @"level_id",
             @"losenum" : @"losenum",
             @"recommend_count" : @"recommend_count",
             @"role_id" : @"role_id",
             @"winnum" : @"winnum",
             @"profit_rate" : @"profit_rate",
             @"win_rate" : @"win_rate",
             @"goodPlay" : @"goodplay",
             @"goodsclass" : @"goodsclass",
             @"Recoommandmodel" : @"news",
             @"arrNearten" : @"nearten",
             @"arrTotalrate" : @"totalrate",
             @"nickname" : @"nickname",
             @"pic" : @"pic",
             @"userinfo" : @"userinfo",
             @"usertitle" : @"usertitle",
             @"arrUsertitle" : @"usertitle",
             @"medals" : @"medals",
             };
}
+ (NSValueTransformer *)goodPlayJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSGoodPlayModel class]];
}
+ (NSValueTransformer *)goodsclassJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSGoodsclassModel class]];
}
+ (NSValueTransformer *)RecoommandmodelJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSTuijiandatingModel class]];
}
+ (NSValueTransformer *)arrTotalrateJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSTotalrateModel class]];
}
+ (NSValueTransformer *)arrUsertitleJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSUsermarkModel class]];
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSMedalsModel class]];
}
@end
