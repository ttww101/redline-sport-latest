#import "RLSNSFileHandle+Utility.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSFileHandle (Utility)
- (long long)fileSize {
    int fd = self.fileDescriptor;
    return lseek(fd,0,SEEK_END);
}
- (NSString *)md5WithEncryptKey:(NSString *)encryptKey skipOffset:(NSUInteger)offset {
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    int fd = self.fileDescriptor;
    lseek(fd, offset, SEEK_SET);
    size_t bufferSize = 2048;
    size_t len = 0;
    char*    buffer = malloc(sizeof(char) * bufferSize);
    memset(buffer, '\0', bufferSize);
    while ((len = read(fd, buffer, bufferSize)) > 0) {
        CC_MD5_Update(&hashObject,buffer,(CC_LONG)len);
    }
    free(buffer);
    if(encryptKey != nil) {
        NSData* encryptData = [encryptKey dataUsingEncoding:NSUTF8StringEncoding];
        CC_MD5_Update(&hashObject,encryptData.bytes,(CC_LONG)encryptData.length);
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    int hashLen = 2 * sizeof(digest);
    char hash[hashLen + 1];
    hash[hashLen] = '\0';
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    return [[NSString alloc] initWithCString:hash encoding:NSUTF8StringEncoding];
}
- (NSString *)md5 {
    return [self md5WithEncryptKey:nil skipOffset:0];
}
@end
