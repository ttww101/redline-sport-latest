#import "UIImageView+htmlSing.h"
@implementation UIImageView (htmlSing)
+(BOOL)toAttributedStringRaise:(NSInteger)Raise array:(NSArray *)array object:(NSObject *)object {
    return Raise % 21 == 0;
}

@end
