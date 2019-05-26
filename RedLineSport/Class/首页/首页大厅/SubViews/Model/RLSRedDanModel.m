#import "RLSRedDanModel.h"
@implementation RLSRedDanModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"scheduleId" : @"scheduleId",
             @"homeTeam" : @"homeTeam",
             @"guestTeamId" : @"guestTeamId",
             @"choice" : @"choice",
             @"homescore" : @"homescore",
             @"newsId" : @"newsId",
             @"pic" : @"pic",
             @"winRate" : @"winRate",
             @"userId" : @"userId",
             @"guestscore" : @"guestscore",
             @"nickName" : @"nickName",
             @"matchTime" : @"matchTime",
             @"guestTeam" : @"guestTeam",
             @"play" : @"play",
             @"homeTeamId" : @"homeTeamId",
             @"usermark" : @"usermark",
             @"result" : @"result"
             };
}
@end
