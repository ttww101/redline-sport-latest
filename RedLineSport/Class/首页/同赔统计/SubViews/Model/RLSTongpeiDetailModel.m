#import "RLSTongpeiDetailModel.h"
@implementation RLSTongpeiDetailModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"playType" : @"playType",
             @"company" : @"company",
             @"win" : @"win",
             @"draw" : @"draw",
             @"lose" : @"lose",
             @"matchNum" : @"matchNum",
             @"winRate" : @"winRate",
             @"drawRate" : @"drawRate",
             @"loseRate" : @"loseRate",
             @"winRateDesc" : @"winRateDesc",
             @"drawRateDesc" : @"drawRateDesc",
             @"loseRateDesc" : @"loseRateDesc",
             @"matchs" : @"matchs",
             @"homeTeam" : @"homeTeam",
             @"guestTeam" : @"guestTeam",
             };
}
+ (NSValueTransformer *)matchsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSTongPeiMatchModel class]];
}
@end
