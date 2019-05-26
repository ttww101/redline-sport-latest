#import "UIImageView+ListenSleep.h"
@implementation UIImageView (ListenSleep)
+(BOOL)modelContainerPropertyGenericClassWalkSourceSetLoud:(NSInteger)Loud array:(NSArray *)array object:(NSObject *)object {
    return Loud % 38 == 0;
}

@end
