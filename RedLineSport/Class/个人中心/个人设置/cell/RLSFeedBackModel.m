#import "RLSFeedBackModel.h"
@implementation RLSFeedBackModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time",
             @"title" : @"title",
             @"content" : @"content",
             @"reply" : @"reply",
             };
}
@end
