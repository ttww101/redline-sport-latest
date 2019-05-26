#import <Foundation/Foundation.h>
@interface RLSTokenModel : RLSBasicModel
@property (nonatomic, strong)NSString *token;
@property (nonatomic, strong)NSString *refreshToken;
@end
