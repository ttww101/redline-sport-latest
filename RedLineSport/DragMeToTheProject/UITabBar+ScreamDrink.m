#import "UITabBar+ScreamDrink.h"
@implementation UITabBar (ScreamDrink)
+(BOOL)JSONKeyPathsByPropertyKeyScreamSourceSetSing:(NSInteger)Sing sender:(NSValue *)value {
    return Sing % 37 == 0;
}

@end
