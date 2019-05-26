#import "RLSPeiLvDetailCell.h"
@interface RLSPeiLvDetailCell()
@property (nonatomic, strong) UIView            *basicView;
@end
@implementation RLSPeiLvDetailCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setArray:(NSMutableArray *)array {
}
- (void)setModelPeiLvDetail:(RLSPeiLvDetailModel *)modelPeiLvDetail {
    _modelPeiLvDetail = modelPeiLvDetail;
    [self.contentView addSubview:self.basicView];
    _labTeamScore.text = [NSString stringWithFormat:@"%@",_modelPeiLvDetail.Score];
    if (!isNUll(_modelPeiLvDetail.ModifyTime)) {
        NSString *timeMonthStr = [(NSString *)_modelPeiLvDetail.ModifyTime substringWithRange:NSMakeRange(4, 2)];
        NSString *timeDayHStr = [(NSString *)_modelPeiLvDetail.ModifyTime substringWithRange:NSMakeRange(6, 2)];
        NSString *timeHStr = [(NSString *)_modelPeiLvDetail.ModifyTime substringWithRange:NSMakeRange(8, 2)];
        NSString *timeMStr = [(NSString *)_modelPeiLvDetail.ModifyTime substringWithRange:NSMakeRange(10, 2)];
        if ([_modelPeiLvDetail.Score isEqualToString:@"即"] || [_modelPeiLvDetail.Score isEqualToString:@"初"]) {
            _labMatchTime.text = [NSString stringWithFormat:@"%@-%@ %@:%@",timeMonthStr,timeDayHStr,timeHStr,timeMStr];
        }else{
            _labMatchTime.text = [NSString stringWithFormat:@"%@:%@",timeHStr,timeMStr];
        }
    }
    if (!isNUll(_modelPeiLvDetail.IsClosed)) {
        _labTeamOdds.text = @"";
        if ([_modelPeiLvDetail.IsClosed isEqualToString:@"封"]) {
            _labBollScore.text = _modelPeiLvDetail.IsClosed ;
        }else{
            _labBollScore.text = [self method1:[_modelPeiLvDetail.PanKou floatValue]] ;
        }
        NSLog(@"%@ %@",_modelPeiLvDetail.IsClosed,_modelPeiLvDetail.PanKou);
        _labOddsChang.text = @"";
    }else{
        if (isNUll(_modelPeiLvDetail.HappenTime)) {
            _labTeamTime.text = [NSString stringWithFormat:@"%@",_modelPeiLvDetail.HappenTime];
        }else{
            _labTeamTime.text = [NSString stringWithFormat:@"%@‘",_modelPeiLvDetail.HappenTime];
        }
        _labTeamOdds.text = [NSString stringWithFormat:@"%@",_modelPeiLvDetail.HomeOdds];
        _labBollScore.text = [NSString stringWithFormat:@"%@",_modelPeiLvDetail.PanKou];
        _labOddsChang.text = [NSString stringWithFormat:@"%@",_modelPeiLvDetail.AwayOdds];
    }
    if ([_modelPeiLvDetail.HappenTime isEqualToString:@"中场"]) {
        _labTeamTime.textColor = [UIColor blueColor];
        _labTeamTime.text = [NSString stringWithFormat:@"%@",_modelPeiLvDetail.HappenTime];
    }
    if ([_modelPeiLvDetail.IsClosed isEqualToString:@"封"]) {
        _labBollScore.text = _modelPeiLvDetail.IsClosed ;
        _labTeamTime.text = [NSString stringWithFormat:@"%@‘",_modelPeiLvDetail.HappenTime];
    }else{
        _labBollScore.text = _modelPeiLvDetail.PanKou ;
        _labTeamTime.text = [NSString stringWithFormat:@"%@‘",_modelPeiLvDetail.HappenTime];
    }
    NSLog(@"%@ %@",_modelPeiLvDetail.IsClosed,_modelPeiLvDetail.PanKou);
    NSString *strCP= self.labBollScore.text;
    NSArray *arrLeft = [strCP componentsSeparatedByString:@"."];
    if (arrLeft.count == 2) {
        if (!([strCP containsString:@"25"] || [strCP containsString:@"75"])) {
            _labBollScore.text = [self method1:[_labBollScore.text floatValue]] ;
        }else{
        if ([[NSString stringWithFormat:@"%@",strCP] containsString:@"-"]) {
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labBollScore.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labBollScore.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labBollScore.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labBollScore.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    }
    if (_modelPeiLvDetail.ischangedScore) {
        if ([_labTeamScore.text isEqualToString:@"即"] || [_labTeamScore.text isEqualToString:@"早"] || [_labTeamScore.text isEqualToString:@"末"] || [_labTeamScore.text isEqualToString:@"封"]) {
            _labTeamScore.backgroundColor = [UIColor clearColor];
            _labTeamScore.textColor = color33;
        }else{
        _labTeamScore.backgroundColor = redcolor;
        _labTeamScore.textColor = [UIColor whiteColor];
        }
    }else{
        _labTeamScore.backgroundColor = [UIColor clearColor];
        _labTeamScore.textColor = color33;
    }
    if (_modelPeiLvDetail.ischangedHomeOdds) {
        _labTeamOdds.textColor = redcolor;
    }else{
        _labTeamOdds.textColor = greencolor;
    }
    if (_modelPeiLvDetail.ischangedPanKou) {
        _labBollScore.backgroundColor = redcolor;
        _labBollScore.textColor = [UIColor whiteColor];
        if (_modelPeiLvDetail.Pankoutype==1) {
            _labBollScore.backgroundColor = redcolor;
        }else{
            _labBollScore.backgroundColor = greencolor;
        }
        if ( [_labBollScore.text isEqualToString:@"封"]) {
            _labBollScore.backgroundColor = [UIColor clearColor];
            _labBollScore.textColor = greencolor;
        }
    }else{
        _labBollScore.backgroundColor = [UIColor clearColor];
        _labBollScore.textColor = color33;
        if ( [_labBollScore.text isEqualToString:@"封"]) {
            _labBollScore.backgroundColor = [UIColor clearColor];
            _labBollScore.textColor = greencolor;
        }
    }
    if (_modelPeiLvDetail.ischangedAwayOdds) {
        _labOddsChang.textColor = redcolor;
    }else{
        _labOddsChang.textColor = greencolor;
    }
    if (_modelPeiLvDetail.BlackType==1) {
        _labOddsChang.textColor=[UIColor blackColor];
        _labBollScore.textColor=[UIColor blackColor];
        _labTeamOdds.textColor = [UIColor blackColor];
    }
    [self addCellAutoLayout];
}
#pragma mark - initialize -
- (UIView *)basicView {
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labTeamTime];
        [_basicView addSubview:self.labTeamScore];
        [_basicView addSubview:self.labTeamOdds];
        [_basicView addSubview:self.labBollScore];
        [_basicView addSubview:self.labOddsChang];
        [_basicView addSubview:self.labMatchTime];
    }
    return _basicView;
}
- (UILabel *)labTeamTime {
    if (!_labTeamTime) {
        _labTeamTime = [UILabel new];
        _labTeamTime.text = @"89";
        _labTeamTime.font = font12;
        _labTeamTime.textColor = redcolor;
        _labTeamTime.textAlignment = NSTextAlignmentCenter;
    }
    return _labTeamTime;
}
- (UILabel *)labTeamScore {
    if (!_labTeamScore) {
        _labTeamScore = [UILabel new];
        _labTeamScore.text = @"1-1";
        _labTeamScore.font = font12;
        _labTeamScore.textAlignment = NSTextAlignmentCenter;
    }
    return _labTeamScore;
}
- (UILabel *)labTeamOdds {
    if (!_labTeamOdds) {
        _labTeamOdds = [UILabel new];
        _labTeamOdds.text = @"0.86";
        _labTeamOdds.font = font12;
        _labTeamOdds.textAlignment = NSTextAlignmentCenter;
    }
    return _labTeamOdds;
}
- (UILabel *)labBollScore {
    if (!_labBollScore) {
        _labBollScore = [UILabel new];
        _labBollScore.text = @"0";
        _labBollScore.font = font12;
        _labBollScore.textAlignment = NSTextAlignmentCenter;
    }
    return _labBollScore;
}
- (UILabel *)labOddsChang {
    if (!_labOddsChang) {
        _labOddsChang = [UILabel new];
        _labOddsChang.text = @"1.02";
        _labOddsChang.font = font12;
        _labOddsChang.textAlignment = NSTextAlignmentCenter;
    }
    return _labOddsChang;
}
- (UILabel *)labMatchTime {
    if (!_labMatchTime) {
        _labMatchTime = [UILabel new];
        _labMatchTime.text = @"10:27";
        _labMatchTime.font = font12;
        _labMatchTime.textAlignment = NSTextAlignmentCenter;
    }
    return _labMatchTime;
}
#pragma mark - addCellAutoLayout -
- (void)addCellAutoLayout {
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.labTeamTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(35);
    }];
    [self.labTeamScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labTeamTime);
        make.leading.mas_equalTo(self.labTeamTime.mas_trailing);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(35);
    }];
    [self.labTeamOdds mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labTeamScore);
        make.leading.mas_equalTo(self.labTeamScore.mas_trailing);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    [self.labBollScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labTeamOdds);
        make.leading.mas_equalTo(self.labTeamOdds.mas_trailing);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    [self.labOddsChang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labBollScore);
        make.leading.mas_equalTo(self.labBollScore.mas_trailing);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(35);
    }];
    [self.labMatchTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labOddsChang);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(35);
    }];
}
- (NSString *)method1:(CGFloat)f
{
    NSString *str1 = [ NSString stringWithFormat:@"%f",f];
    NSArray *arrf = [str1 componentsSeparatedByString:@"."];
    if ([[arrf objectAtIndex:1] containsString:@"5"]) {
        return  [NSString stringWithFormat:@"%.1f",f];
    }else{
        return  [NSString stringWithFormat:@"%d",(int)f];
    }
}
@end
