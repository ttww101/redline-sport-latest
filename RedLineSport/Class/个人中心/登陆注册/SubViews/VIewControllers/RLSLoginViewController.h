#import "RLSBasicViewController.h"
typedef NS_ENUM(NSInteger,typeLogin)
{
    typeLoginNormal = 1,
    typeLoginThirdParth = 2,
};
typedef NS_ENUM(NSInteger,isBangTitleType)
{
    zhuCeType = 0,
    bangDingType = 1,
};
@interface RLSLoginViewController : RLSBasicViewController
@property (nonatomic, assign) typeLogin type;
@property (nonatomic, assign) isBangTitleType bangType;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *resource;
@end
