#define TAB_BAR_TAP_BUTTON_BASE_BAG 1000
#import "RLSCustmerTableBar.h"
#import "RLSTabbarButton.h"
@implementation RLSCustmerTableBar
- (instancetype)init {
    self = [super init];
    if (self) {
        self.selected = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setItemsArr:(NSArray *)itemsArr {
    _itemsArr = itemsArr;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    RLSTabbarButton *defultSelectBtn = nil;
    for (int i = 0; i < _itemsArr.count; i++) {
        NSDictionary *dic = itemsArr[i];
        CGFloat itemsWith = self.frame.size.width / _itemsArr.count;
        RLSTabbarButton *tabbar = [[RLSTabbarButton alloc] initWithFrame:CGRectMake(itemsWith * i, 0, itemsWith, self.frame.size.height)];
        tabbar.isLoad        = self.isLoad;
        tabbar.deflut        = self.arrayDefluts[i];
        tabbar.select        = self.arraySelects[i];
        [tabbar setTabbarImage:dic[@"image"] selectedImage:dic[@"selectedImage"] title:dic[@"title"]];
        tabbar.tag = TAB_BAR_TAP_BUTTON_BASE_BAG + i;
        [tabbar addTarget:self action:@selector(clickTabButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tabbar];
        if (i == 0) {
            defultSelectBtn = tabbar;
        }
    }
    [self clickTabButton:defultSelectBtn];
}
- (void)clickTabButton:(RLSTabbarButton *)clickBtn {
    NSInteger to_tag = clickBtn.tag - TAB_BAR_TAP_BUTTON_BASE_BAG;
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        BOOL success = [self.delegate tabBar:self selectedFrom:self.selected to:to_tag];
        if (success) {
            for (RLSTabbarButton *btn in self.subviews) {
                btn.selected = NO;
            }
            self.selected = to_tag;
            clickBtn.selected = YES;
        }
    }
}
@end
