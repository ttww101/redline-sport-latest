#import "RLSTongPeiMatchModel.h"
@implementation RLSTongPeiMatchModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sclassName" : @"sclassName",
             @"sclassColor" : @"sclassColor",
             @"matchTime" : @"matchTime",
             @"homeTeam" : @"homeTeam",
             @"guestTeam" : @"guestTeam",
             @"homeScore" : @"homeScore",
             @"guestScore" : @"guestScore",
             @"firstWin" : @"firstWin",
             @"firstDraw" : @"firstDraw",
             @"firstLose" : @"firstLose",
             @"finalWin" : @"finalWin",
             @"finalDraw" : @"finalDraw",
             @"finalLose" : @"finalLose",
             @"result" : @"result",
             @"resultColor" : @"resultColor",
             };
}
@end
