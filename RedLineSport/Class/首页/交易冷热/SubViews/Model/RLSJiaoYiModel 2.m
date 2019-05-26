#import "RLSJiaoYiModel.h"
@implementation RLSJiaoYiModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sid" : @"sid",
             @"sort":@"sort",
             @"league" : @"league",
             @"mtime":@"mtime",
             @"type" : @"type",
             @"deal":@"deal",
             @"bifa":@"bifa",
             @"maxval":@"maxval",
             @"hometeam":@"hometeam",
             @"guestteam":@"guestteam",
             @"homescore":@"homescore",
             @"guestscore":@"guestscore",
             @"matchstate":@"matchstate"
             };
}
@end
