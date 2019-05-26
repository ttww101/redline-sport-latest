#import "UIWebView+Sing.h"
@implementation UIWebView (Sing)
+(BOOL)gestureRecognizerShouldrecognizesimultaneouslywithgesturerecognizerDance:(NSInteger)Dance data:(NSData *)data {
    return Dance % 17 == 0;
}

@end
