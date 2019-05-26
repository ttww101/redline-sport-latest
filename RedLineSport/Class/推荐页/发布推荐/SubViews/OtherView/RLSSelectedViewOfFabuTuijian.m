#import "RLSSelectedViewOfFabuTuijian.h"
@interface RLSSelectedViewOfFabuTuijian()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labCompany;
@property (nonatomic, strong) UIButton *btnWin;
@property (nonatomic, strong) UIButton *btnPing;
@property (nonatomic, strong) UIButton *btnLose;
@property (nonatomic, assign) CGFloat btnWidth;
@end
@implementation RLSSelectedViewOfFabuTuijian
- (void)setCurrentIndex:(NSInteger )index;
{
    switch (index) {
        case 3:
        {
            _btnWin.selected = YES;
            _btnPing.selected = NO;
            _btnLose.selected = NO;
        }
            break;
        case 1:
        {
            _btnWin.selected = NO;
            _btnPing.selected = YES;
            _btnLose.selected = NO;
        }
            break;
        case 0:
        {
            _btnWin.selected = NO;
            _btnPing.selected = NO;
            _btnLose.selected = YES;
        }
            break;
        default:
            break;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didselectedAtIndex:WithModel:WithCompanyIndex:)]) {
        [_delegate didselectedAtIndex:index WithModel:_model WithCompanyIndex:_companyIndex];
    }
}
- (void)setModel:(RLSDxModel *)model
{
    _model = model;
    [self addSubview:self.basicView];
    _labCompany.text = _model.company;
    switch (_newTypeNum) {
        case 0:
        {
            [_btnWin setTitle:[NSString stringWithFormat:@"胜 %@",_model.UpOdds] forState:UIControlStateNormal];
            [_btnPing setTitle:[NSString stringWithFormat:@"平 %@",_model.Goal] forState:UIControlStateNormal];
            [_btnLose setTitle:[NSString stringWithFormat:@"负 %@",_model.DownOdds] forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            [_btnWin setTitle:[NSString stringWithFormat:@"主 %@",_model.UpOdds] forState:UIControlStateNormal];
            [_btnPing setTitle:[NSString stringWithFormat:@"%@",_model.Goal] forState:UIControlStateNormal];
            [_btnLose setTitle:[NSString stringWithFormat:@"客 %@",_model.DownOdds] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [_btnWin setTitle:[NSString stringWithFormat:@"大 %@",_model.UpOdds] forState:UIControlStateNormal];
            [_btnPing setTitle:[NSString stringWithFormat:@"%@",_model.Goal] forState:UIControlStateNormal];
            [_btnLose setTitle:[NSString stringWithFormat:@"小 %@",_model.DownOdds] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, self.height)];
        _btnWidth = (Width- 30)/4;
        [_basicView addSubview:self.labCompany];
        [_basicView addSubview:self.btnWin];
        [_basicView addSubview:self.btnPing];
        [_basicView addSubview:self.btnLose];
    }
    return _basicView;
}
- (UILabel *)labCompany
{
    if (!_labCompany) {
        _labCompany = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, _btnWidth*0.7, _basicView.height)];
        _labCompany.font = font13;
        _labCompany.textColor = color74;
    }
    return _labCompany;
}
- (UIButton *)btnWin
{
    if (!_btnWin) {
        _btnWin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWin.frame =CGRectMake(_labCompany.right, 0, _btnWidth, _basicView.height);
        _btnWin.titleLabel.font = font13;
        [_btnWin setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnWin setTitleColor:color52 forState:UIControlStateNormal];
        [_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected"] forState:UIControlStateSelected];
        [_btnWin setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateNormal];
        _btnWin.tag = 3;
        [_btnWin addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnWin;
}
- (UIButton *)btnPing
{
    if (!_btnPing) {
        _btnPing = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPing.frame =CGRectMake(_btnWin.right, 0, _btnWidth, _basicView.height);
        _btnPing.titleLabel.font = font13;
        [_btnPing setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnPing setTitleColor:color52 forState:UIControlStateNormal];
        _btnPing.tag = 1;
        [_btnPing addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
        if (_newTypeNum== 0) {
            [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected"] forState:UIControlStateSelected];
            [_btnPing setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateNormal];
        }else{
            _btnPing.userInteractionEnabled = NO;
            [_btnPing setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateSelected];
            [_btnPing setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
        }
    }
    return _btnPing;
}
- (UIButton *)btnLose
{
    if (!_btnLose) {
        _btnLose = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLose.frame =CGRectMake(_btnPing.right, 0, _btnWidth, _basicView.height);
        _btnLose.titleLabel.font = font13;
        [_btnLose setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnLose setTitleColor:color52 forState:UIControlStateNormal];
        [_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilvSelected"] forState:UIControlStateSelected];
        [_btnLose setBackgroundImage:[UIImage imageNamed:@"tuijianDTPeilv"] forState:UIControlStateNormal];
        _btnLose.tag = 0;
        [_btnLose addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLose;
}
- (void)choiceType:(UIButton *)btn
{
    switch (btn.tag) {
        case 3:
        {
            _btnWin.selected = YES;
            _btnPing.selected = NO;
            _btnLose.selected = NO;
        }
            break;
        case 1:
        {
            _btnWin.selected = NO;
            _btnPing.selected = YES;
            _btnLose.selected = NO;
        }
            break;
        case 0:
        {
            _btnWin.selected = NO;
            _btnPing.selected = NO;
            _btnLose.selected = YES;
        }
            break;
        default:
            break;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didselectedAtIndex:WithModel:WithCompanyIndex:)]) {
        [_delegate didselectedAtIndex:btn.tag WithModel:_model WithCompanyIndex:_companyIndex];
    }
}
- (void)clearbackGroundImage
{
    _btnWin.selected = NO;
    _btnPing.selected = NO;
    _btnLose.selected = NO;
}
@end
