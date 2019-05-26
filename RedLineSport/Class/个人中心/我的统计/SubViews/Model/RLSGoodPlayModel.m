#import "RLSGoodPlayModel.h"
@implementation RLSGoodPlayModel
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"playname" : @"playname",
             @"profitRate" : @"profitRate",
             @"winRate" : @"winRate",
             @"gonum" : @"gonum",
             @"losenum" : @"losenum",
             @"recommendCount" : @"recommendCount",
             @"winnum" : @"winnum",
             };
}
@end
