#import "RLSLiveListModel.h"
@implementation RLSLiveListModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
}
@end
@implementation LiveListArrayModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"RLSLiveListModel") };
}
@end
