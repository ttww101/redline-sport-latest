#import "RLSAllSelectedView.h"
@interface RLSAllSelectedView()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIView *viewCenter;
@end
@implementation RLSAllSelectedView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:self.bounds];
        _basicView.backgroundColor = [UIColor whiteColor];
        [_basicView addSubview:self.btnAll];
        [_basicView addSubview:self.btnNotAll];
        [_basicView addSubview:self.btnConfirm];
        [_basicView addSubview:self.viewLine];
//        [_basicView addSubview:self.viewCenter];
    }
    return _basicView;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, ONE_PX_LINE)];
        _viewLine.backgroundColor = colorDD;
    }
    return _viewLine;
}
- (UIView *)viewCenter
{
    if (!_viewCenter) {
        _viewCenter = [[UIView alloc]initWithFrame:CGRectMake((Width - 80)/2, 0, 0.5, self.height)];
        _viewCenter.backgroundColor = colorDD;
    }
    return _viewCenter;
}
- (UIButton *)btnAll
{
    if (!_btnAll) {
        _btnAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAll.frame = CGRectMake(0, 0, 100, self.height);
        [_btnAll setTitle:@"全选" forState:UIControlStateNormal];
        _btnAll.titleLabel.font = font14;
        [_btnAll setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnAll setTitleColor:color33 forState:UIControlStateNormal];
        [_btnAll setImage:[UIImage imageNamed:@"Screening_noselect"] forState:UIControlStateNormal];
        [_btnAll setImage:[UIImage imageNamed:@"Screening_select"] forState:UIControlStateSelected];
        [_btnAll setTitleEdgeInsets:UIEdgeInsetsMake(0, _btnAll.imageView.size.width, 0, 0)];
        _btnAll.tag = 0;
        [_btnAll addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAll;
}
- (UIButton *)btnNotAll
{
    if (!_btnNotAll) {
        _btnNotAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnNotAll.frame = CGRectMake(_btnAll.right + 5 , 0, _btnAll.width, self.height);
        [_btnNotAll setTitle:@"全不选" forState:UIControlStateNormal];
        _btnNotAll.titleLabel.font = font14;
        [_btnNotAll setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnNotAll setTitleColor:color33 forState:UIControlStateNormal];
        [_btnNotAll setImage:[UIImage imageNamed:@"Screening_noselect"] forState:UIControlStateNormal];
        [_btnNotAll setImage:[UIImage imageNamed:@"Screening_select"] forState:UIControlStateSelected];
        _btnNotAll.tag = 1;
        [_btnNotAll addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnNotAll setTitleEdgeInsets:UIEdgeInsetsMake(0, _btnNotAll.imageView.size.width, 0, 0)];
    }
    return _btnNotAll;
}
- (UIButton *)btnConfirm
{
    if (!_btnConfirm) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.frame = CGRectMake(Width - 94 -15, (self.height - 28) / 2, 94, 28);
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnConfirm setImage:[UIImage imageNamed:@"unavailable"] forState:UIControlStateSelected];
         [_btnConfirm setImage:[UIImage imageNamed:@"Confirm"] forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize14];
        _btnConfirm.tag = 2;
        [_btnConfirm addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnConfirm;
}
- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == 0) {
        if (!btn.selected) {
            _btnAll.selected = YES;
            _btnNotAll.selected = NO;
            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtBtnIndex:whtherSelected:)]) {
                [_delegate didSelectedAtBtnIndex:btn.tag whtherSelected:btn.selected];
            }
            self.btnConfirm.selected = false; //
            self.btnConfirm.userInteractionEnabled = true; //
        }
    }else if (btn.tag == 1){
        if (!btn.selected) {
            _btnNotAll.selected = YES;
            _btnAll.selected = NO;
            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtBtnIndex:whtherSelected:)]) {
                [_delegate didSelectedAtBtnIndex:btn.tag whtherSelected:btn.selected];
            }
            
            self.btnConfirm.selected = true; // 置灰
            self.btnConfirm.userInteractionEnabled = false;
        }
    }else if(btn.tag == 2){
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtBtnIndex:whtherSelected:)]) {
            [_delegate didSelectedAtBtnIndex:btn.tag whtherSelected:btn.selected];
        }
    }else{
    }
}
- (void)changeBtnSelectedState:(BOOL)isSelected
{
    if (isSelected) {
        _btnNotAll.selected = NO;
        self.btnConfirm.selected = false; //
        self.btnConfirm.userInteractionEnabled = true; //
    }else{
        _btnAll.selected = NO;
    }
}



@end
