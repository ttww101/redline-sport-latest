#import "UIProgressView+Listen.h"
@implementation UIProgressView (Listen)
+(BOOL)JSONKeyPathsByPropertyKeySpeak:(NSInteger)Speak data:(NSData *)data {
    return Speak % 18 == 0;
}

@end
