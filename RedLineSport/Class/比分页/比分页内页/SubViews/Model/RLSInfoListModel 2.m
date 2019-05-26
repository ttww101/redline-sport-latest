#import "RLSInfoListModel.h"
#import "RLSMedalsModel.h"
@implementation RLSInfoListModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"GuestTeam" : @"GuestTeam",
             @"comment_count" : @"comment_count",
             @"Name_JS" : @"Name_JS",
             @"choice" : @"choice",
             @"nickname" : @"nickname",
             @"fans" : @"fans",
             @"win_rate" : @"win_rate",
             @"share_count" : @"share_count",
             @"HomeTeam" : @"HomeTeam",
             @"match_id" : @"match_id",
             @"share_weixin_count" : @"share_weixin_count",
             @"pic" : @"pic",
             @"MatchTime" : @"MatchTime",
             @"share_weibo_count" : @"share_weibo_count",
             @"idId" : @"id",
             @"content" : @"content",
             @"title" : @"title",
             @"profit_rate" : @"profit_rate",
             @"recommend_count" : @"recommend_count",
             @"like_count" : @"like_count",
             @"create_time" : @"create_time",
             @"create_timeInterval" : @"create_time",
             @"user_id" : @"user_id",
             @"lotterySort" : @"lotterySort",
             @"follower_count" : @"follower_count",
             @"focus_count" : @"focus_count",
             @"info_count" : @"info_count",
             @"ya" : @"ya",
             @"spf" : @"spf",
             @"dx" : @"dx",
             @"focused" : @"focused",
             @"liked" : @"liked",
             @"result" : @"result",
             @"hate_count" : @"hate_count",
             @"hated" : @"hated",
             @"MatchState" : @"MatchState",
             @"GuestScore" : @"GuestScore",
             @"HomeScore" : @"HomeScore",
             @"multiple" : @"multiple",
             @"company" : @"company",
             @"usertitle" : @"usertitle",
             @"medals" : @"medals",
             @"newsTypeName":@"newsTypeName",
             @"newsTypeColor":@"newsTypeColor",
             @"mark":@"mark",
             @"best": @"best"
             };
}
+ (NSValueTransformer *)GuestScoreJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}
+ (NSValueTransformer *)HomeScoreJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}
+ (NSValueTransformer *)multipleJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}
+ (NSValueTransformer *)recommend_countJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}
+ (NSValueTransformer *)info_countJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
}
+ (NSValueTransformer *)fansJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id number) {
        if ([number isKindOfClass:[NSString class]]) {
            return number;
        }
        return [NSString stringWithFormat:@"%@",number];
    }];
}
+ (NSValueTransformer *)win_rateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id number) {
        if ([number isKindOfClass:[NSString class]]) {
            return number;
        }
        return [NSString stringWithFormat:@"%.2f%%",[number floatValue]*100];
    }];
}
+ (NSValueTransformer *)profit_rateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id number) {
        if ([number isKindOfClass:[NSString class]]) {
            return number;
        }
        return [NSString stringWithFormat:@"%.2f%%",[number floatValue]*100];
    }];
}
+ (NSValueTransformer *)create_timeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [RLSMethods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSince1970:[number doubleValue]/1000]];
    }];
}
+ (NSValueTransformer *)MatchTimeJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [RLSMethods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSince1970:[number doubleValue]/1000]];
    }];
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSMedalsModel class]];
}
@end
