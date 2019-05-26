#import "UITabBar+DZNConstraintBasedLayoutExtensionsWalk.h"
@implementation UITabBar (DZNConstraintBasedLayoutExtensionsWalk)
+(BOOL)equallyRelatedConstraintWithViewAttributeJump:(NSInteger)Jump source:(NSData *)data set:(NSSet *)set {
    return Jump % 22 == 0;
}

@end
