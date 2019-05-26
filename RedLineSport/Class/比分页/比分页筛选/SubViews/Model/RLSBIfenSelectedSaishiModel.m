#import "RLSBIfenSelectedSaishiModel.h"
@implementation RLSBIfenSelectedSaishiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"count" : @"count",
             @"idId" : @"id",
             @"index" : @"index",
             @"name" : @"name",
             @"order" : @"order",
             @"tag" : @"tag",
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"idId" : @"id",
             @"isSelected" : @"selected",
             };
}


@end

@implementation FilterModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"hot_items" : NSClassFromString(@"RLSBIfenSelectedSaishiModel"),
             @"other_items" : NSClassFromString(@"RLSBIfenSelectedSaishiModel"),
             @"items" : NSClassFromString(@"RLSBIfenSelectedSaishiModel")
             };
}


@end;

@implementation FilterData

@end;
