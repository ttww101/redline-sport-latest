#import "RLSRonyunDataSource.h"
@implementation RLSRonyunDataSource
+ (RLSRonyunDataSource *)shareInstance {
    static RLSRonyunDataSource *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
@end
