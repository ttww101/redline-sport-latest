#import "RLSTongPeiTJModel.h"
@implementation RLSTongPeiTJModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"scheduleId" : @"scheduleId",
             @"symbol" : @"symbol",
             @"sclassId" : @"sclassId",
             @"sclassName" : @"sclassName",
             @"sclassColor" : @"sclassColor",
             @"matchTime" : @"matchTime",
             @"homeTeam" : @"homeTeam",
             @"guestTeam" : @"guestTeam",
             @"company" : @"company",
             @"win" : @"win",
             @"draw" : @"draw",
             @"lose" : @"lose",
             @"rate" : @"rate",
             @"rateDesc" : @"rateDesc",
             @"resultColor" : @"resultColor",
             @"num" : @"num",
             };
}
@end
