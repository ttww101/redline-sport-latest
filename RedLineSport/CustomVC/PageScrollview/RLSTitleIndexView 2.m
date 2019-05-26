#import "RLSTitleIndexView.h"
@interface RLSTitleIndexView()
@property (nonatomic, strong) NSMutableArray *arrBtns;
@property (nonatomic, strong) UIView *viewPage;
@end
@implementation RLSTitleIndexView
- (void)updateSelectedIndex:(NSInteger)index
{
    [_arrBtns enumerateObjectsUsingBlock:^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            obj.selected = YES;
            CGFloat pageW = 0;
            if (_pageWidth>0) {
                pageW  = _pageWidth;
            }else{
                CGSize textSize = [[obj currentTitle] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font14,NSFontAttributeName, nil]];
                pageW = textSize.width;
            }
            self.viewPage.frame = CGRectMake(0, self.height - 3 -3, pageW + 10, 3);
            self.viewPage.center = CGPointMake(obj.center.x, self.viewPage.center.y);
        }else{
            obj.selected = NO;
        }
    }];
}
- (void)selectedEndNO:(NSInteger)index{
    [_arrBtns enumerateObjectsUsingBlock:^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            obj.userInteractionEnabled = NO;
            [obj setTitleColor:colorF5A19A forState:UIControlStateNormal];
        }
    }];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (UIView *)viewPage
{
    if (!_viewPage ) {
        _viewPage = [[UIView alloc] init];
        if (self.lineColor) {
            _viewPage.backgroundColor = self.lineColor;
        }else{
           _viewPage.backgroundColor = redcolor;
        }
        _viewPage.layer.cornerRadius = 1.5;
        _viewPage.layer.masksToBounds = YES;
    }
    return _viewPage;
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    _arrBtns = [NSMutableArray array];
    CGFloat btnwidth = Width/_arrData.count;
    [_arrData enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnwidth*idx, 0, btnwidth, self.height);
        btn.titleLabel.font = font14;
        btn.tag = idx;
        if (!self.seletedColor) {
            [btn setTitleColor:color33 forState:UIControlStateNormal];
            [btn setTitleColor:redcolor forState:UIControlStateSelected];
        }else{
            [btn setTitleColor:self.nalColor forState:UIControlStateNormal];
            [btn setTitleColor:self.seletedColor forState:UIControlStateSelected];
        }
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(updateSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_arrBtns addObject:btn];
    }];
    [self addSubview:self.viewPage];
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, self.width, 0.5)];
    if (!_bottomLineColor) {
        _bottomLineColor = [UIColor clearColor];
    }
    viewLine.backgroundColor = _bottomLineColor;
    [self addSubview:viewLine];
    [self updateSelectedIndex:_selectedIndex];
}
- (void)updateSelected:(UIButton *)btn
{
    [self updateSelectedIndex:btn.tag];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtIndex:)]) {
        [_delegate didSelectedAtIndex:btn.tag];
    }
}
@end
