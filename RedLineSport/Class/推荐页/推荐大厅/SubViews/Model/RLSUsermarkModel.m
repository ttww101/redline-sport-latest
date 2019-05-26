#import "RLSUsermarkModel.h"
@implementation RLSUsermarkModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"createTime" : @"createTime",
             @"remark" : @"remark",
             @"type" : @"type",
             @"userId" : @"userId",
             @"isvalid" : @"isvalid",
             };
}
@end
