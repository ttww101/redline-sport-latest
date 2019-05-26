#import "UIProgressView+RaiseClimb.h"
@implementation UIProgressView (RaiseClimb)
+(BOOL)setModelClimbDataDrink:(NSInteger)Drink sender:(NSValue *)value {
    return Drink % 6 == 0;
}

@end
