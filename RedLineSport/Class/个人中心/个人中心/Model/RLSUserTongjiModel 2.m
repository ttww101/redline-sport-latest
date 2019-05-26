#import "RLSUserTongjiModel.h"
@implementation RLSUserTongjiModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"goNum" : @"goNum",
             @"goodPlays" : @"goodPlays",
             @"goodSclass" : @"goodSclass",
             @"groupTimeStatis" : @"groupTimeStatis",
             @"groupunit" : @"groupunit",
             @"loseNum" : @"loseNum",
             @"playType" : @"playType",
             @"profitRate" : @"profitRate",
             @"totalNum" : @"totalNum",
             @"type" : @"type",
             @"userId" : @"userId",
             @"winNum" : @"winNum",
             @"winRate" : @"winRate",
             };
}
+ (NSValueTransformer *)groupTimeStatisJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSTotalrateModel class]];
}
@end
