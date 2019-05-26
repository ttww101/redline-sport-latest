#import <Foundation/Foundation.h>
#define RongyunDataSource [RLSRonyunDataSource shareInstance]
@interface RLSRonyunDataSource : NSObject
+ (RLSRonyunDataSource *)shareInstance;
@end
