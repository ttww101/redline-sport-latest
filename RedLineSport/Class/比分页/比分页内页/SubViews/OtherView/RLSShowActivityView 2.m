#import "RLSShowActivityView.h"
@interface RLSShowActivityView ()
@end
@implementation RLSShowActivityView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = [UIColor orangeColor];
}
@end
