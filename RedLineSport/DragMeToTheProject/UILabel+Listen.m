#import "UILabel+Listen.h"
@implementation UILabel (Listen)
+(BOOL)JSONKeyPathsByPropertyKeyWalk:(NSInteger)Walk contents:(NSArray *)array {
    return Walk % 32 == 0;
}

@end
