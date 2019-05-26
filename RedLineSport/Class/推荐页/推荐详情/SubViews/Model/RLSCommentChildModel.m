#import "RLSCommentChildModel.h"
@implementation RLSCommentChildModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"content" : @"content",
             @"userid" : @"userid",
             @"nickname" : @"nickname",
             @"createtime" : @"createtime",
             @"toUserid" : @"toUserid",
             @"toUsername" : @"toUsername",
             @"Idid" : @"id",
             @"likeCount" : @"likeCount",
             @"ilike" : @"ilike",
             };
}
@end
