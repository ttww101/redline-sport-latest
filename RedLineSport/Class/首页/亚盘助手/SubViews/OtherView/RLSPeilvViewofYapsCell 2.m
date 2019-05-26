#import "RLSPeilvViewofYapsCell.h"
@interface RLSPeilvViewofYapsCell()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, assign) BOOL isaddLayout;
@property (nonatomic, strong) UILabel *labJPTitle;
@property (nonatomic, strong) UILabel *labJP1;
@property (nonatomic, strong) UILabel *labJP2;
@property (nonatomic, strong) UILabel *labJP3;
@property (nonatomic, strong) UILabel *labCPTitle;
@property (nonatomic, strong) UILabel *labCP1;
@property (nonatomic, strong) UILabel *labCP2;
@property (nonatomic, strong) UILabel *labCP3;
@property (nonatomic, strong) UILabel *labTimeCP;
@property (nonatomic, strong) UILabel *labTimeJP;
@property (nonatomic, strong) UILabel *labchangeNum;
@property (nonatomic, strong) UILabel *labchangeTitle;
@property (nonatomic, strong) UIView *viewProcess;
@end
@implementation RLSPeilvViewofYapsCell
- (void)setModel:(RLSPlycModel *)model
{
    _model = model;
    [self addSubview:self.basicView];
    if (!_isaddLayout) {
        _isaddLayout = YES;
        [self addlayout];
    }
    [self.viewProcess mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width- 80, _model.panProcess.count*20));
    }];
    _labJPTitle.text = @"即赔:";
    _labJP1.text  = _model.finalWin;
    _labJP2.text  = _model.finalDraw;
    _labJP3.text  = _model.finalLose;
    if (!isNUll(_model.finalTimeCn)&& ![_model.finalTimeCn isEqualToString:@"全部"]) {
        _labTimeJP.text = _model.finalTimeCn;
    }else{
        _labTimeJP.text = [RLSMethods timeToNowWith:_model.finalTime];
    }
    _labCPTitle.text = @"初赔:";
    _labCP1.text  = _model.firstWin;
    _labCP2.text  = _model.firstDraw;
    _labCP3.text  = _model.firstLose;
    _labTimeCP.text = [RLSMethods timeToNowWith:_model.firstTime];
    _labchangeTitle.text = @"变化次数";
    _labchangeNum.text = [NSString stringWithFormat:@"%ld次",_model.changeNum];
    _labJPTitle.frame = CGRectMake(0, _labCPTitle.bottom + 6.5  + _model.panProcess.count*20, 35, 13);
    _labJP1.center = CGPointMake(_labJP1.center.x, _labJPTitle.center.y);
    _labJP2.center = CGPointMake(_labJP2.center.x, _labJPTitle.center.y);
    _labJP3.center = CGPointMake(_labJP3.center.x, _labJPTitle.center.y);
    _labTimeJP.center = CGPointMake(_labTimeJP.center.x, _labJPTitle.center.y);
    [_viewProcess removeAllSubViews];
    for (int i = 0; i<_model.panProcess.count; i++) {
        RLSPanProcessModel *process = [_model.panProcess objectAtIndex:i];
        UIView *viewP  = [[UIView alloc] initWithFrame:CGRectMake(0, i*20, Width - 80, 20)];
        [_viewProcess addSubview:viewP];
        UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 31.5, 12.5)];
        lab1.textColor = color33;
        lab1.font = font10;
        lab1.layer.borderColor = colorE8.CGColor;
        lab1.layer.borderWidth = 0.6;
        lab1.textAlignment = NSTextAlignmentCenter;
        lab1.text = [NSString stringWithFormat:@"%@",process.upodds] ;
        [viewP addSubview:lab1];
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(lab1.right, 0, 35, 12.5)];
        lab2.center = CGPointMake(lab2.center.x, lab1.center.y);
        lab2.textColor = color33;
        lab2.font = font10;
        lab2.backgroundColor = colorTableViewBackgroundColor;
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.adjustsFontSizeToFitWidth = YES;
        lab2.text = process.goal;
        [viewP addSubview:lab2];
        UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake( lab2.right,0, 31.5, 12.5)];
        lab3.center = CGPointMake(lab3.center.x, lab1.center.y);
        lab3.textColor = color33;
        lab3.font = font10;
        lab3.layer.borderColor = colorE8.CGColor;
        lab3.layer.borderWidth = 0.6;
        lab3.textAlignment = NSTextAlignmentCenter;
        lab3.text = [NSString stringWithFormat:@"%@",process.downodds] ;
        [viewP addSubview:lab3];
       UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(lab3.right + 8.5, 0, 50, 10)];
        labTime.center = CGPointMake(labTime.center.x, lab1.center.y);
        labTime.textColor = color99;
        labTime.font = font7;
        labTime.text = [RLSMethods timeToNowWith:process.modifyTime];
        [viewP addSubview:labTime];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labCPTitle];
        [_basicView addSubview:self.labCP1];
        [_basicView addSubview:self.labCP2];
        [_basicView addSubview:self.labCP3];
        [_basicView addSubview:self.labTimeCP];
        [_basicView addSubview:self.labJPTitle];
        [_basicView addSubview:self.labJP1];
        [_basicView addSubview:self.labJP2];
        [_basicView addSubview:self.labJP3];
        [_basicView addSubview:self.labTimeJP];
        [_basicView addSubview:self.labchangeNum];
        [_basicView addSubview:self.labchangeTitle];
        [_basicView addSubview:self.viewProcess];
    }
    return _basicView;
}
- (UILabel *)labJPTitle
{
    if (!_labJPTitle) {
        _labJPTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, _labCPTitle.bottom + 6.5, 35, 13)];
        _labJPTitle.textColor = color99;
        _labJPTitle.font = font10;
        _labJPTitle.textAlignment = NSTextAlignmentRight;
    }
    return _labJPTitle;
}
- (UILabel *)labJP1
{
    if (!_labJP1) {
        _labJP1 = [[UILabel alloc] initWithFrame:CGRectMake(_labJPTitle.right + 5, 0, 31.5, 12.5)];
        _labJP1.center = CGPointMake(_labJP1.center.x, _labJPTitle.center.y);
        _labJP1.textColor = color33;
        _labJP1.font = font10;
        _labJP1.layer.borderColor = colorE8.CGColor;
        _labJP1.layer.borderWidth = 0.6;
        _labJP1.textAlignment = NSTextAlignmentCenter;
    }
    return _labJP1;
}
- (UILabel *)labJP2
{
    if (!_labJP2) {
        _labJP2 = [[UILabel alloc] initWithFrame:CGRectMake(_labJP1.right, 0, 35, 12.5)];
        _labJP2.center = CGPointMake(_labJP2.center.x, _labJPTitle.center.y);
        _labJP2.textColor = color33;
        _labJP2.font = font10;
        _labJP2.layer.borderColor = colorE8.CGColor;
        _labJP2.layer.borderWidth = 0.6;
        _labJP2.backgroundColor = colorTableViewBackgroundColor;
        _labJP2.adjustsFontSizeToFitWidth = YES;
        _labJP2.textAlignment = NSTextAlignmentCenter;
    }
    return _labJP2;
}
- (UILabel *)labJP3
{
    if (!_labJP3) {
        _labJP3 = [[UILabel alloc] initWithFrame:CGRectMake(_labJP2.right, 0, 31.5, 12.5)];
        _labJP3.center = CGPointMake(_labJP3.center.x, _labJPTitle.center.y);
        _labJP3.textColor = color33;
        _labJP3.font = font10;
        _labJP3.layer.borderColor = colorE8.CGColor;
        _labJP3.layer.borderWidth = 0.6;
        _labJP3.textAlignment = NSTextAlignmentCenter;
    }
    return _labJP3;
}
- (UILabel *)labTimeJP
{
    if (!_labTimeJP) {
        _labTimeJP = [[UILabel alloc] initWithFrame:CGRectMake(_labJP3.right + 8.5, 0, 50, 10)];
        _labTimeJP.center = CGPointMake(_labTimeJP.center.x, _labJPTitle.center.y);
        _labTimeJP.textColor = color99;
        _labTimeJP.font = font7;
    }
    return _labTimeJP;
}
- (UILabel *)labCPTitle
{
    if (!_labCPTitle) {
        _labCPTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 35, 13)];
        _labCPTitle.textColor = color99;
        _labCPTitle.font = font10;
        _labCPTitle.textAlignment = NSTextAlignmentRight;
    }
    return _labCPTitle;
}
- (UILabel *)labCP1
{
    if (!_labCP1) {
        _labCP1 = [[UILabel alloc] initWithFrame:CGRectMake(_labCPTitle.right + 5, 0, 31.5, 12.5)];
        _labCP1.center = CGPointMake(_labCP1.center.x, _labCPTitle.center.y);
        _labCP1.textColor = color33;
        _labCP1.font = font10;
        _labCP1.layer.borderColor = colorE8.CGColor;
        _labCP1.layer.borderWidth = 0.6;
        _labCP1.textAlignment = NSTextAlignmentCenter;
    }
    return _labCP1;
}
- (UILabel *)labCP2
{
    if (!_labCP2) {
        _labCP2 = [[UILabel alloc] initWithFrame:CGRectMake(_labCP1.right, 0, 35, 12.5)];
        _labCP2.center = CGPointMake(_labCP2.center.x, _labCPTitle.center.y);
        _labCP2.textColor = color33;
        _labCP2.font = font10;
        _labCP2.layer.borderColor = colorE8.CGColor;
        _labCP2.layer.borderWidth = 0.6;
        _labCP2.backgroundColor = colorTableViewBackgroundColor;
        _labCP2.adjustsFontSizeToFitWidth = YES;
        _labCP2.textAlignment = NSTextAlignmentCenter;
    }
    return _labCP2;
}
- (UILabel *)labCP3
{
    if (!_labCP3) {
        _labCP3 = [[UILabel alloc] initWithFrame:CGRectMake(_labCP2.right, 0, 31.5, 12.5)];
        _labCP3.center = CGPointMake(_labCP3.center.x, _labCPTitle.center.y);
        _labCP3.textColor = color33;
        _labCP3.font = font10;
        _labCP3.layer.borderColor = colorE8.CGColor;
        _labCP3.layer.borderWidth = 0.6;
        _labCP3.textAlignment = NSTextAlignmentCenter;
    }
    return _labCP3;
}
- (UILabel *)labTimeCP
{
    if (!_labTimeCP) {
        _labTimeCP = [[UILabel alloc] initWithFrame:CGRectMake(_labCP3.right + 8.5, 0, 50, 10)];
        _labTimeCP.center = CGPointMake(_labTimeCP.center.x, _labCPTitle.center.y);
        _labTimeCP.textColor = color99;
        _labTimeCP.font = font7;
    }
    return _labTimeCP;
}
- (UILabel *)labchangeNum
{
    if (!_labchangeNum) {
        _labchangeNum = [[UILabel alloc] init];
        _labchangeNum.textColor = redcolor;
        _labchangeNum.font = font12;
    }
    return _labchangeNum;
}
- (UILabel *)labchangeTitle
{
    if (!_labchangeTitle) {
        _labchangeTitle = [[UILabel alloc] init];
        _labchangeTitle.textColor = color66;
        _labchangeTitle.font = font11;
    }
    return _labchangeTitle;
}
- (UIView *)viewProcess
{
    if (!_viewProcess) {
        _viewProcess = [[UIView alloc] init];
    }
    return _viewProcess;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.viewProcess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(31);
        make.left.equalTo(self.basicView.mas_left).offset(40);
        make.size.mas_equalTo(CGSizeMake(Width- 80, _model.panProcess.count*20));
    }];
    [self.labchangeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.labchangeTitle.mas_centerX).offset(0);
        make.bottom.equalTo(self.labchangeTitle.mas_top).offset(-4);
    }];
    [self.labchangeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-22);
        make.bottom.equalTo(self.basicView.mas_bottom).offset(-12);
    }];
}
@end
