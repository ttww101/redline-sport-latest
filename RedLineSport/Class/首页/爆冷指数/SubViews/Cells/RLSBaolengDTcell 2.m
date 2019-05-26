#import "RLSBaolengDTcell.h"
@interface RLSBaolengDTcell()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labLeague;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labHomteam;
@property (nonatomic, strong) UILabel *labGuestteam;
@property (nonatomic, strong) UILabel *labVS;
@property (nonatomic, strong) UILabel *labPeilvUp;
@property (nonatomic, strong) UILabel *labpeilvGoal;
@property (nonatomic, strong) UILabel *labPeilvDown;
@end
@implementation RLSBaolengDTcell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(RLSBaolengMatchModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    _labLeague.text = _model.league;
    _labTime.text = [RLSMethods getDateByStyle:DateFormatterYearH withDate:[NSDate dateWithTimeIntervalSince1970:_model.matchtime/1000] ];
    _labHomteam.text = _model.hometeam;
    _labVS.text = [NSString stringWithFormat:@"%ld-%ld",_model.homescore,_model.guestscore];
    _labGuestteam.text = _model.guestteam;
    _labPeilvUp.text = _model.FirstHomeWin;
    _labpeilvGoal.text = _model.FirstStandoff;
    _labPeilvDown.text = _model.FirstGuestWin;
    _labPeilvUp.backgroundColor = [UIColor whiteColor];
    _labpeilvGoal.backgroundColor = [UIColor whiteColor];
    _labPeilvDown.backgroundColor = [UIColor whiteColor];
    _labPeilvUp.textColor = color66;
    _labpeilvGoal.textColor = color66;
    _labPeilvDown.textColor = color66;
    if (_model.homescore> _model.guestscore) {
        if (([_model.FirstHomeWin floatValue]>=[_model.FirstGuestWin floatValue]) && ([_model.FirstHomeWin floatValue]>=[_model.FirstStandoff floatValue])) {
            _labPeilvUp.backgroundColor = redcolor;
            _labPeilvUp.textColor = [UIColor whiteColor];
        }else if (([_model.FirstHomeWin floatValue]>=[_model.FirstGuestWin floatValue]) || ([_model.FirstHomeWin floatValue]>=[_model.FirstStandoff floatValue])){
            _labPeilvUp.backgroundColor = colorD8CB29;
            _labPeilvUp.textColor = [UIColor whiteColor];
        }else{
        }
    }else if (_model.homescore< _model.guestscore) {
        if (([_model.FirstGuestWin floatValue]>=[_model.FirstHomeWin floatValue]) && ([_model.FirstGuestWin floatValue]>=[_model.FirstStandoff floatValue])) {
            _labPeilvDown.backgroundColor = redcolor;
            _labPeilvDown.textColor = [UIColor whiteColor];
        }else if (([_model.FirstGuestWin floatValue]>=[_model.FirstHomeWin floatValue]) || ([_model.FirstGuestWin floatValue]>=[_model.FirstStandoff floatValue])){
            _labPeilvDown.backgroundColor = colorD8CB29;
            _labPeilvDown.textColor = [UIColor whiteColor];
        }else{
        }
    }else{
        if (([_model.FirstStandoff floatValue]>=[_model.FirstGuestWin floatValue]) && ([_model.FirstStandoff floatValue]>=[_model.FirstHomeWin floatValue])) {
            _labpeilvGoal.backgroundColor = redcolor;
            _labpeilvGoal.textColor = [UIColor whiteColor];
        }else if (([_model.FirstStandoff floatValue]>=[_model.FirstGuestWin floatValue]) || ([_model.FirstStandoff floatValue]>=[_model.FirstHomeWin floatValue])){
            _labpeilvGoal.backgroundColor = colorD8CB29;
            _labpeilvGoal.textColor = [UIColor whiteColor];
        }else{
        }
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30)];
        [_basicView addSubview:self.labLeague];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labHomteam];
        [_basicView addSubview:self.labGuestteam];
        [_basicView addSubview:self.labVS];
        [_basicView addSubview:self.labPeilvUp];
        [_basicView addSubview:self.labpeilvGoal];
        [_basicView addSubview:self.labPeilvDown];
    }
    return _basicView;
}
- (UILabel *)labLeague
{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 28)];
        _labLeague.font = font12;
        _labLeague.textColor = color66;
    }
    return _labLeague;
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 50, 15)];
        _labTime.font = font10;
        _labTime.textColor = color99;
    }
    return _labTime;
}
- (UILabel *)labHomteam
{
    if (!_labHomteam) {
        _labHomteam = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, (Width - 60 - 35 - 120)/2, 30)];
        _labHomteam.font = font12;
        _labHomteam.textAlignment = NSTextAlignmentRight;
        _labHomteam.textColor = color33;
    }
    return _labHomteam;
}
- (UILabel *)labGuestteam
{
    if (!_labGuestteam) {
        _labGuestteam = [[UILabel alloc] initWithFrame:CGRectMake(_labHomteam.right + 35, 0, (Width - 60 - 35 - 120)/2, 30)];
        _labGuestteam.font = font12;
        _labGuestteam.textColor = color33;
    }
    return _labGuestteam;
}
- (UILabel *)labVS
{
    if (!_labVS) {
        _labVS = [[UILabel alloc] initWithFrame:CGRectMake(_labHomteam.right, 0, 35, 30)];
        _labVS.font = font12;
        _labVS.textColor = color99;
        _labVS.textAlignment = NSTextAlignmentCenter;
    }
    return _labVS;
}
- (UILabel *)labPeilvUp
{
    if (!_labPeilvUp) {
        _labPeilvUp = [[UILabel alloc] initWithFrame:CGRectMake(_labGuestteam.right + 6, 0, 35, 15)];
        _labPeilvUp.center = CGPointMake(_labPeilvUp.center.x, _basicView.center.y);
        _labPeilvUp.layer.cornerRadius = 3;
        _labPeilvUp.layer.masksToBounds = YES;
        _labPeilvUp.font = font12;
        _labPeilvUp.textColor = color66;
        _labPeilvUp.textAlignment = NSTextAlignmentCenter;
    }
    return _labPeilvUp;
}
- (UILabel *)labpeilvGoal
{
    if (!_labpeilvGoal) {
        _labpeilvGoal = [[UILabel alloc] initWithFrame:CGRectMake(_labPeilvUp.right + 2, 0, 35, 15)];
        _labpeilvGoal.center = CGPointMake(_labpeilvGoal.center.x, _basicView.center.y);
        _labpeilvGoal.layer.cornerRadius = 3;
        _labpeilvGoal.layer.masksToBounds = YES;
        _labpeilvGoal.font = font12;
        _labpeilvGoal.textColor = color66;
        _labpeilvGoal.textAlignment = NSTextAlignmentCenter;
    }
    return _labpeilvGoal;
}
- (UILabel *)labPeilvDown
{
    if (!_labPeilvDown) {
        _labPeilvDown = [[UILabel alloc] initWithFrame:CGRectMake(_labpeilvGoal.right + 2, 0, 35, 15)];
        _labPeilvDown.center = CGPointMake(_labPeilvDown.center.x, _basicView.center.y);
        _labPeilvDown.layer.cornerRadius = 3;
        _labPeilvDown.layer.masksToBounds = YES;
        _labPeilvDown.font = font12;
        _labPeilvDown.textColor = color66;
        _labPeilvDown.textAlignment = NSTextAlignmentCenter;
    }
    return _labPeilvDown;
}
@end
