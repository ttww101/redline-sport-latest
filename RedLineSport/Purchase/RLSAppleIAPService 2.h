#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, IAPPurchaseStatus)
{
    IAPPurchaseFailed,      
    IAPPurchaseSucceeded,   
    IAPRestoredFailed,      
    IAPRestoredSucceeded,   
};
typedef void(^MsgBlock)(NSString *message, NSError *error);
@protocol AppleIAPServiceDelegate <NSObject>
-(void)IAPFailedWithWrongInfor:(NSString *)informationStr;
-(void)IAPPaySuccessFunctionWithBase64:(NSString *)base64Str;
@end
@interface RLSAppleIAPService : NSObject
@property(nonatomic ,weak) id<AppleIAPServiceDelegate> IAPDelegate;
+ (instancetype)sharedInstance;
+ (void)checkTheIAPStatusFunction;
-(void)addTheIAPObserver;
-(void)removeTheIAPOberver;
- (void)getProductInfo:(NSString *)productIdentifier;
-(void)purchase:(id)parameter resultBlock:(MsgBlock)resultBlock;
- (void)VerifyingLocalCredentialsWithBlock:(MsgBlock)resultBlock;
@end
