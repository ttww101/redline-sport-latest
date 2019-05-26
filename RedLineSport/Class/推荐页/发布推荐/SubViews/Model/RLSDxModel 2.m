#import "RLSDxModel.h"
@implementation RLSDxModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"DownOdds" : @"downodds" ,
             @"Goal" : @"goal" ,
             @"UpOdds" : @"upodds" ,
             @"company" : @"company",
             @"odds":@"odds",
             @"homeDesc":@"homeDesc",
             @"guestDesc":@"guestDesc",
             };
}
+ (NSValueTransformer *)DownOddsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return (NSString *)[NSString stringWithFormat:@"%.2f",[number floatValue]];
        return nil;
    }];
}
+ (NSValueTransformer *)UpOddsJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
        return [NSString stringWithFormat:@"%.2f",[number floatValue]];
        return nil;
    }];
}
@end
