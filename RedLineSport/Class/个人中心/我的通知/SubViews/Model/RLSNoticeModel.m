#import "RLSNoticeModel.h"
@implementation RLSNoticeModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"mid" : @"mid",
             @"title" : @"title",
             @"content" : @"content",
             @"iread" : @"iread",
             @"time" : @"time",
             };
}
@end
