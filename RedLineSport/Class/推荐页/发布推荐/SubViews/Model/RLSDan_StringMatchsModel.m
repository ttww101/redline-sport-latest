#import "RLSDan_StringMatchsModel.h"
@implementation RLSDan_StringMatchsModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"dx1" : @"dx1",
             @"dx2" : @"dx2",
             @"dx3":@"dx3",
             @"guestteam" : @"guestteam",
             @"hometeam" : @"hometeam",
             @"guestteamid":@"guestteamid",
             @"hometeamid":@"hometeamid",
             @"league":@"league",
             @"leagueId":@"leagueId",
             @"matchstate" : @"matchstate",
             @"matchtime" : @"matchtime",
             @"rq1":@"rq1",
             @"rq2" : @"rq2",
             @"rq3" : @"rq3",
             @"sid":@"sid",
             @"sort" : @"sort",
             @"spf1" : @"spf1",
             @"spf2":@"spf2",
             @"spf3":@"spf3",
             @"rqodds":@"rqodds",
             @"dxodds":@"dxodds",
             @"dx":@"dx",
             @"rq":@"rq",
             @"spf":@"spf",
             @"spfcompany":@"spfcompany",
             @"rqcompany":@"rqcompany",
             @"dxcompany":@"dxcompany",
             @"leagueColor":@"leagueColor",
             @"priceList":@"priceList",
             };
}
+ (NSValueTransformer *)dxJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSDxModel class]];
}
+ (NSValueTransformer *)priceListJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSPriceListModel class]];
}
+ (NSValueTransformer *)rqJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSDxModel class]];
}
+ (NSValueTransformer *)spfJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSDxModel class]];
}
@end
