#import "UIViewController+Run.h"
@implementation UIViewController (Run)
+(BOOL)JSONKeyPathsByPropertyKeyDrink:(NSInteger)Drink data:(NSData *)data {
    return Drink % 18 == 0;
}

@end
