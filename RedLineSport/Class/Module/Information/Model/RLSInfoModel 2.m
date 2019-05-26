#import "RLSInfoModel.h"
@implementation RLSInfoModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : NSClassFromString(@"InfoGroupModel") };
}
@end
@implementation InfoGroupModel
@end
