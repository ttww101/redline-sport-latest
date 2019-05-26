#import "RLSFirstPInfoListModel.h"
@implementation RLSFirstPInfoListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"choice" : @"choice",
             @"color" : @"color",
             @"content" : @"content",
             @"createtime" : @"createtime",
             @"downodds" : @"downodds",
             @"goals" : @"goals",
             @"grouping" : @"grouping",
             @"guestrank" : @"guestrank",
             @"guestscore" : @"guestscore",
             @"guestteam" : @"guestteam",
             @"guestteamid" : @"guestteamid",
             @"homerank" : @"homerank",
             @"homescore" : @"homescore",
             @"hometeam" : @"hometeam",
             @"hometeamid" : @"hometeamid",
             @"isindex" : @"isindex",
             @"league" : @"league",
             @"leagueId" : @"leagueId",
             @"location" : @"location",
             @"matchstate" : @"matchstate",
             @"mtime" : @"mtime",
             @"neutrality" : @"neutrality",
             @"newsid" : @"newsid",
             @"round" : @"round",
             @"sid" : @"sid",
             @"tag" : @"tag",
             @"tid" : @"tid",
             @"title" : @"title",
             @"upodds" : @"upodds",
             @"weekDayName" : @"weekDayName",
             @"matchintro" : @"matchintro",
             @"matchtime" : @"matchtime",
             @"ya" : @"ya",
             @"dx" : @"dx",
             @"spf" : @"spf",
             @"mid" : @"mid",
             @"recommand" : @"recommand",
             @"info" : @"info",
             @"matchtime2" : @"matchtime2",
             };
}
+ (NSValueTransformer *)yaJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSDxModel class]];
}
+ (NSValueTransformer *)dxJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSDxModel class]];
}
+ (NSValueTransformer *)spfJSONTransformer
{
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[RLSDxModel class]];
}
@end
