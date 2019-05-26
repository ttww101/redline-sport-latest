#import <Foundation/Foundation.h>
@interface RLSTFFileUploadManager : NSObject<NSURLConnectionDataDelegate>
+(instancetype)shareInstance;
-(void)uploadFileWithURL:(NSString*)urlString params:(NSDictionary*)params fileKey:(NSString*)fileKey filePath:(NSString*)filePath completeHander:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))completeHander;
@end
