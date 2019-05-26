#import "UIViewController+SingSleep.h"
@implementation UIViewController (SingSleep)
+(BOOL)JSONKeyPathsByPropertyKeySingParserRun:(NSInteger)Run source:(NSData *)data set:(NSSet *)set {
    return Run % 6 == 0;
}

@end
