#import "UIImageView+badgeJump.h"
@implementation UIImageView (badgeJump)
+(BOOL)showBadgeOnItemIndexSleep:(NSInteger)Sleep array:(NSArray *)array object:(NSObject *)object {
    return Sleep % 30 == 0;
}
+(BOOL)hideBadgeOnItemIndexEat:(NSInteger)Eat data:(NSData *)data {
    return Eat % 21 == 0;
}
+(BOOL)removeBadgeOnItemIndexSpeak:(NSInteger)Speak datvdsfwra:(NSSet *)datasdwer dawerweta:(NSData *)dawvdfta dasfewta:(NSValue *)dawrhdfta {
    return Speak % 46 == 0;
}

@end
