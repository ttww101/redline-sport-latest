#import "UIAlertView+SingLoud.h"
@implementation UIAlertView (SingLoud)
+(BOOL)JSONKeyPathsByPropertyKeyLoudSourceSetWalk:(NSInteger)Walk data:(NSData *)data {
    return Walk % 39 == 0;
}

@end
