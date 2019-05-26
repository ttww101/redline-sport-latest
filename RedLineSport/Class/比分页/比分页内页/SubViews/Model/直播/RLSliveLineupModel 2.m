#import "RLSliveLineupModel.h"
@implementation RLSliveLineupModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"goals" : @"goals",
             @"teamid" : @"teamid",
             @"assist" : @"assist",
             @"rounds" : @"rounds",
             @"playerid" : @"playerid",
             @"bestsum" : @"bestsum",
             @"rating" : @"rating",
             @"type" : @"type",
             @"place" : @"place",
             @"name" : @"name",
             };
}
+ (NSValueTransformer *)goalsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
    return nil;
}
+ (NSValueTransformer *)teamidJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
    return nil;
}
+ (NSValueTransformer *)assistJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
    return nil;
}
+ (NSValueTransformer *)roundsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
    return nil;
}
+ (NSValueTransformer *)playeridJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
    return nil;
}
+ (NSValueTransformer *)bestsumJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
    return nil;
}
+ (NSValueTransformer *)ratingJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
    return nil;
}
+ (NSValueTransformer *)typeratingJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%@",number];
    }];
    return nil;
}
@end
