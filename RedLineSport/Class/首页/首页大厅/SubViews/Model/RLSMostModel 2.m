#import "RLSMostModel.h"
@implementation RLSMostModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sid" : @"sid",
             @"league" : @"league",
             @"hometeam" : @"hometeam",
             @"guestteam" : @"guestteam",
             @"hometeamid" : @"hometeamid",
             @"guestteamid" : @"guestteamid",
             @"teamname" : @"teamname",
             @"mark":@"mark",
             @"historymostresult":@"historymostresult",
             @"mostresult":@"mostresult",
             @"type":@"type",
             @"sort":@"sort",
             @"name":@"name",
             @"maxname":@"maxname"
             };
}
@end
