#import "RLSBattleModel.h"
@implementation RLSBattleModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"homename" : @"homename",
             @"guestname" : @"guestname",
             @"homenumber" : @"homenumber",
             @"guestnumber" : @"guestnumber",
             @"homeplayerid" : @"homeplayerid",
             };
}
@end
