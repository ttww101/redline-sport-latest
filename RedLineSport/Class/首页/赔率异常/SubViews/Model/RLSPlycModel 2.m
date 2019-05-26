#import "RLSPlycModel.h"
@implementation RLSPlycModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"amp" : @"amp",
             @"companyId" : @"companyId",
             @"companyName" : @"companyName",
             @"drawAmp" : @"drawAmp",
             @"finalDraw" : @"finalDraw",
             @"finalLose" : @"finalLose",
             @"finalWin" : @"finalWin",
             @"firstDraw" : @"firstDraw",
             @"firstLose" : @"firstLose",
             @"guestTeam" : @"guestTeam",
             @"homeTeam" : @"homeTeam",
             @"idId" : @"id",
             @"loseAmp" : @"loseAmp",
             @"matchTime" : @"matchTime",
             @"matchType" : @"matchType",
             @"oddType" : @"oddType",
             @"scheduleId" : @"scheduleId",
             @"sclassName" : @"sclassName",
             @"statisTime" : @"statisTime",
             @"symbol" : @"symbol",
             @"timeType" : @"timeType",
             @"type" : @"type",
             @"winAmp" : @"winAmp",
             @"changeNum" : @"changeNum",
             @"panProcess" : @"panProcess",
             @"finalTime" : @"finalTime",
             @"firstTime" : @"firstTime",
             @"oddsId" : @"oddsId",
             @"finalTimeCn" : @"finalTimeCn",
             };
}
+ (NSValueTransformer *)panProcessJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSPanProcessModel class]];
}
@end
