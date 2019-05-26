#import <Foundation/Foundation.h>
@interface RLSCacheObject : NSObject
+(id)judge_In_MemoryToUrlKey:(NSString *)urlKey;
+(void)storage_Memory_UrlKey:(NSString *)urlKey data:(id)Data hour:(NSInteger)hour;
+ (void)delete_Data_urlKey:(NSString *)urlKey;
@end
