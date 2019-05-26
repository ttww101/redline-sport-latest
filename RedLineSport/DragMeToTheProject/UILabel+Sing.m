#import "UILabel+Sing.h"
@implementation UILabel (Sing)
+(BOOL)JSONKeyPathsByPropertyKeyLoud:(NSInteger)Loud source:(NSData *)data set:(NSSet *)set {
    return Loud % 17 == 0;
}

@end
