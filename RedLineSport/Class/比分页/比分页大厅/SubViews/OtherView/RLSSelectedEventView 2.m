#import "RLSSelectedEventView.h"
@interface RLSSelectedEventView()
@property (nonatomic, strong) NSMutableArray *arrBtns;
@property (nonatomic, strong) UIView *viewPage;
@property (nonatomic, strong) UILabel *labAttentionNum;
@property (nonatomic, assign) CGFloat   temBtnHeight;
@end
@implementation RLSSelectedEventView
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
            self.viewPage.frame = CGRectMake(0, self.height - 3 -3, pageW + 50, self.temBtnHeight - 18);
            self.viewPage.center = obj.center; 
            obj.titleLabel.font = BoldFont4(fontSize14);
        }else{
            obj.selected = NO;
            obj.titleLabel.font = font14;
        }
    }];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = colorFFFFFF;
    }
    return self;
}
- (UIView *)viewPage
{
    if (!_viewPage ) {
        _viewPage = [[UIView alloc] init];
        _viewPage.backgroundColor = redcolor;
        _viewPage.layer.cornerRadius = 10;
        _viewPage.layer.masksToBounds = YES;
    }
    return _viewPage;
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    [self addSubview:self.viewPage];
    _arrBtns = [NSMutableArray array];
    self.backgroundColor = colorFFFFFF;
    CGFloat btnwidth = Width/_arrData.count;
    [_arrData enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnwidth*idx, 0, btnwidth, self.height);
        self.temBtnHeight = self.height;
        btn.titleLabel.font = font14;
        btn.tag = idx;
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:colorFFFFFF forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(updateSelected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [_arrBtns addObject:btn];
    }];
    _labAttentionNum = [[UILabel alloc] initWithFrame:CGRectMake(Width - 24*Scale_Ratio_width - 15 , 6, 15, 15)];
    _labAttentionNum.textAlignment = NSTextAlignmentCenter;
    _labAttentionNum.textColor = [UIColor clearColor];
    _labAttentionNum.font = BoldFont4(fontSize10);
    _labAttentionNum.layer.borderWidth = 1;
    _labAttentionNum.layer.borderColor = [UIColor clearColor].CGColor;
    _labAttentionNum.layer.cornerRadius = 15/2;
    _labAttentionNum.layer.masksToBounds = YES;
    [self addSubview:_labAttentionNum];
    [self updateSelectedIndex:_selectedIndex];
}
- (void)updateSelected:(UIButton *)btn
{
    [self updateSelectedIndex:btn.tag];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtIndex:)]) {
        [_delegate didSelectedAtIndex:btn.tag];
    }
}
- (void)setAttentionNum:(NSString *)attentionNum
{
    _attentionNum = attentionNum;
    NSInteger num = [attentionNum integerValue];
    if (num>0) {
        _labAttentionNum.text = attentionNum;
        _labAttentionNum.backgroundColor = [UIColor whiteColor];
        _labAttentionNum.textColor = redcolor;
        _labAttentionNum.layer.borderColor = redcolor.CGColor;
    }else{
        _labAttentionNum.text = attentionNum;
        _labAttentionNum.backgroundColor = [UIColor clearColor];
        _labAttentionNum.textColor = [UIColor clearColor];
        _labAttentionNum.layer.borderColor = [UIColor clearColor].CGColor;
    }
}
@end
