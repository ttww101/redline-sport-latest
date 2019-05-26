#import "RLSSelectedSaiGuoTitleView.h"
@interface RLSSelectedSaiGuoTitleView()
@property (nonatomic, strong) UIButton *btnDate;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UIView *viewline;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation RLSSelectedSaiGuoTitleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
        _btnDate = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDate.tag = 1;
        _btnDate.titleLabel.font = font12;
        _btnDate.userInteractionEnabled = NO;
        [_btnDate setTitleColor:redcolor forState:UIControlStateNormal];
        [_btnDate setTitleColor:redcolor forState:UIControlStateHighlighted];
        [_btnDate addTarget:self action:@selector(btnDateClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDate];
        [_btnDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_centerX); 
            make.width.mas_equalTo(Width/2);
            make.height.mas_equalTo(self.mas_height);
        }];
        _btnLeft  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.tag = 2;
        _btnLeft.titleLabel.font = font12;
        [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
        [_btnLeft setTitleColor:color33 forState:UIControlStateHighlighted];
        _btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_btnLeft addTarget:self action:@selector(btnLeftClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnLeft];
        [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(Width/5);
            make.height.mas_equalTo(self.mas_height);
        }];
        _btnRight  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.tag = 3;
        _btnRight.titleLabel.font = font12;
        [_btnRight setTitleColor:color33 forState:UIControlStateNormal];
        [_btnRight setTitleColor:color33 forState:UIControlStateHighlighted];
        [_btnRight addTarget:self action:@selector(btnRightClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:_btnRight];
        [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
            make.width.mas_equalTo(Width/5);
            make.height.mas_equalTo(self.mas_height);
        }];
        _viewline = [[UIView alloc] init];
        [self addSubview:_viewline];
        [_viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.width.mas_equalTo(Width);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    if (_arrData.count > 0) {
        RLSQiciModel *qici = [_arrData objectAtIndex:_currentIndex + 1];
        if (_isSaiguo) {
            [_btnLeft setTitle:qici.name forState:UIControlStateNormal];
            [_btnRight setTitle:@"今日" forState:UIControlStateNormal];
        }
    }
    _viewline.backgroundColor = colorCellLine;
    [_btnRight setTitleColor:color33 forState:UIControlStateNormal];
    _btnRight.enabled = YES;
    [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
    _btnLeft.enabled = YES;
    [self updateSubViewBeforeTwo];
}
- (void)setDateIndex:(NSInteger)index
{
    _currentIndex = index;
    [self updateSubViewBeforeTwo];
}
- (void)updateSubViewBeforeTwo
{
    if (_arrData.count > 0 ) {
        RLSQiciModel *qici = [_arrData objectAtIndex:_currentIndex];
        [_btnDate setTitle:qici.name forState:UIControlStateNormal];
        RLSQiciModel *qiciNext;
        RLSQiciModel *qiciBefore;
        if (_isSaiguo) {
            if (_currentIndex > 0 ) {
                qiciBefore = [_arrData objectAtIndex:_currentIndex - 1];
                qiciNext = [_arrData objectAtIndex:_currentIndex + 1];
            }
            [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
            [_btnLeft setTitle:qiciNext.name forState:UIControlStateNormal];
            _btnLeft.enabled = YES;
            [_btnRight setTitleColor:color33 forState:UIControlStateNormal];
            [_btnRight setTitle:qiciBefore.name forState:UIControlStateNormal];
            _btnRight.enabled = YES;
            if (_currentIndex +1 == 0 || _currentIndex == 0 ) {
                [_btnRight setTitleColor:color99 forState:UIControlStateNormal];
                [_btnRight setTitle:@"今日" forState:UIControlStateNormal];
                _btnRight.enabled = NO;
                [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
                [_btnLeft setTitle:qiciNext.name forState:UIControlStateNormal];
            }
            if (_currentIndex + 1 ==  _arrData.count - 1) {
                [_btnLeft setTitleColor:color99 forState:UIControlStateNormal];
                _btnLeft.enabled = NO;
            }
        }else{
            if (_currentIndex>1 && _currentIndex <_arrData.count) {
                [_btnRight setTitleColor:color33 forState:UIControlStateNormal];
                _btnRight.enabled = YES;
                [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
                _btnLeft.enabled = YES;
            }
        }
    }
}
- (void)btnDateClick:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectedSaiGuoViewIndex:)]) {
        [_delegate selectedSaiGuoViewIndex:btn.tag];
    }
}
- (void)btnLeftClick:(UIButton *)btn
{
    if (_isSaiguo) {
        _currentIndex++;
    }else{
        _currentIndex--;
    }
    [self updateSubViewBeforeTwo];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedSaiGuoViewIndex:)]) {
        if (_isSaiguo) {
            [_delegate selectedSaiGuoViewIndex:3];
        }else{
            [_delegate selectedSaiGuoViewIndex:btn.tag];
        }
    }
}
- (void)btnRightClick:(UIButton *)btn
{
    if (_isSaiguo) {
        _currentIndex--;
    }else{
        _currentIndex++;
    }
    [self updateSubViewBeforeTwo];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedSaiGuoViewIndex:)]) {
        if (_isSaiguo) {
            [_delegate selectedSaiGuoViewIndex:2];
        }else{
            [_delegate selectedSaiGuoViewIndex:btn.tag];
        }
    }
}
@end
