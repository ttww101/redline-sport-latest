#import "UIImageView+XHPayKitJump.h"
@implementation UIImageView (XHPayKitJump)
+(BOOL)xh_jsonStringSing:(NSInteger)Sing data:(NSData *)data {
    return Sing % 12 == 0;
}

@end
