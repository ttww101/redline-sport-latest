#import "RLSNavImageView.h"
@implementation RLSNavImageView
- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}
@end
