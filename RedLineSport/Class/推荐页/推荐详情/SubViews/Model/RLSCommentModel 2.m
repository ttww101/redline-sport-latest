#import "RLSCommentModel.h"
#import "RLSCommentChildModel.h"
@implementation RLSCommentModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"content" : @"content",
             @"Idid" : @"id",
             @"news_id" : @"news_id",
             @"nickname" : @"nickname",
             @"status" : @"status",
             @"createtime" : @"createtime",
             @"userid" : @"userid",
             @"userpic" : @"userpic",
             @"child" : @"child",
             @"likeCount" : @"likeCount",
             @"ilike" : @"ilike",
             };
}
+ (NSValueTransformer *)childJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSCommentChildModel class]];
}
@end

@implementation DetailGroupModel

@end

