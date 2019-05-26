#import <Foundation/Foundation.h>
@interface NSFileHandle (Utility)
- (long long)fileSize;
- (NSString *)md5WithEncryptKey:(NSString *)encryptKey skipOffset:(NSUInteger)offset;
- (NSString *)md5;
@end
