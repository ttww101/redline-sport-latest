#import "RLSTodayHotSpotsCell.h"
@interface RLSTodayHotSpotsCell()
@property (nonatomic, strong)UIView *BGView;
@property (nonatomic, strong)UILabel *labType;
@property (nonatomic, strong)UILabel *labLeague;
@property (nonatomic, strong)UILabel *labTeame;
@property (nonatomic, strong)UILabel *labContent;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *labRedNum;
@property (nonatomic, strong)UILabel *labRedStr;
@property (nonatomic, strong)UILabel *labBlackNum;
@property (nonatomic, strong)UILabel *labBlackStr;
@property (nonatomic, strong)UIView *lineShuView;
@property (nonatomic, assign)BOOL yro;
@end
@implementation RLSTodayHotSpotsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.BGView];
        [self.BGView addSubview:self.labType];
        [self.BGView addSubview:self.labLeague];
        [self.BGView addSubview:self.labTeame];
        [self.BGView addSubview:self.labContent];
        [self.BGView addSubview:self.labRedNum];
        [self.BGView addSubview:self.labRedStr];
        [self.BGView addSubview:self.labBlackNum];
        [self.BGView addSubview:self.labBlackStr];
        [self.BGView addSubview:self.lineView];
        _yro = NO;
    }
    return self;
}
- (void)setRow:(NSInteger)row{
    _row = row;
}
- (UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc] init];
        _BGView.backgroundColor = [UIColor clearColor];
    }
    return _BGView;
}
- (UILabel *)labType{
    if (!_labType) {
        _labType = [[UILabel alloc] init];
        _labType.font = font10;
        _labType.textColor = redcolor;
        _labType.layer.borderColor = redcolor.CGColor;
        _labType.layer.borderWidth = 1;
        _labType.layer.cornerRadius = 3;
        _labType.textAlignment = NSTextAlignmentCenter;
        _labType.text = @"极限";
    }
    return _labType;
}
- (UILabel *)labLeague{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] init];
        _labLeague.font = font12;
        _labLeague.textColor = color66;
        _labLeague.text = @"希腊甲";
    }
    return _labLeague;
}
- (UILabel *)labTeame{
    if (!_labTeame) {
        _labTeame = [[UILabel alloc] init];
        _labTeame.font = font14;
        _labTeame.textColor = color33;
        _labTeame.text = @"新英格兰革";
    }
    return _labTeame;
}
- (UILabel *)labContent{
    if (!_labContent) {
        _labContent = [[UILabel alloc] init];
        _labContent.textColor = color66;
        _labContent.font = font12;
        _labContent.text = @"近期连胜12场，历史最高8场已超过历史极限";
        _labContent.numberOfLines = 2;
    }
    return _labContent;
}
- (UILabel *)labRedNum{
    if (!_labRedNum) {
        _labRedNum = [[UILabel alloc] init];
        _labRedNum.text = @"12";
        _labRedNum.textColor = redcolor;
        _labRedNum.font = font28;
    }
    return _labRedNum;
}
- (UILabel *)labRedStr{
    if (!_labRedStr) {
        _labRedStr = [[UILabel alloc] init];
        _labRedStr.textColor = redcolor;
        _labRedStr.font = font10;
        _labRedStr.textAlignment = NSTextAlignmentCenter;
        _labRedStr.text = @"当前连胜";
    }
    return _labRedStr;
}
- (UILabel *)labBlackNum{
    if (!_labBlackNum) {
        _labBlackNum = [[UILabel alloc] init];
        _labBlackNum.text = @"12";
        _labBlackNum.textColor = color33;
        _labBlackNum.font = font28;
    }
    return _labBlackNum;
}
- (UILabel *)labBlackStr{
    if (!_labBlackStr) {
        _labBlackStr = [[UILabel alloc] init];
        _labBlackStr.textColor = color33;
        _labBlackStr.font = font10;
        _labBlackStr.text = @"历史最高";
    }
    return _labBlackStr;
}
- (UIView *)lineShuView{
    if (!_lineShuView) {
        _lineShuView = [[UIView alloc] init];
        _lineShuView.backgroundColor = colorDD;
    }
    return _lineShuView;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = colorDD;
    }
    return _lineView;
}
-(void)setModel:(RLSMostModel *)model{
    _model = model;
    self.labLeague.text = @"";
    self.labContent.text = model.mark;
    if (!isNUll( self.labContent.text)) {
        self.labContent.attributedText = [RLSMethods setTextStyleWithString:self.labContent.text WithLineSpace:5.5 WithHeaderIndent:200];
    }
    switch (self.row) {
        case 0:{
            if (model.league.length > 4) {
            }
            self.labType.text = @"极限";
            self.labType.textColor = greencolor;
            self.labType.layer.borderColor = greencolor.CGColor;
            self.labTeame.text = model.teamname;
            if (model.teamname.length > 10) {
                self.labTeame.text = [NSString stringWithFormat:@"%@...",[model.teamname substringToIndex:10]];
            }
            self.labRedNum.text = [NSString stringWithFormat:@"%ld",model.mostresult];
            self.labBlackNum.text = [NSString stringWithFormat:@"%ld",model.historymostresult];
            self.labRedStr.text = model.name;
            self.labRedStr.textColor = redcolor;
        }
            break;
        case 1:{
            self.labLeague.text = @" ";
            self.labType.text = @"大热";
            self.labType.textColor = yellowcolor;
            self.labType.layer.borderColor = yellowcolor.CGColor;
            self.labTeame.text = [NSString stringWithFormat:@"%@ vs %@",model.hometeam,model.guestteam];
            self.labRedNum.text = model.sort;
            self.labRedStr.textColor = color66;
            if (!isNUll(self.labRedNum.text) ) {
                self.labRedNum.attributedText = [RLSMethods withContent:self.labRedNum.text WithColorText:@"%" textColor:redcolor strFont:font17];
                if (model.type == 3) {
                    self.labRedStr.text = @"主队交易占比";
                }else if (model.type == 0){
                    self.labRedStr.text = @"客队交易占比";
                }else{
                    self.labRedStr.text = @"平局交易占比";
                }
            }else{
                self.labRedStr.text = @"";
            }
        }
            break;
        case 2:{
            self.labLeague.text = @" ";
            self.labType.text = @"异常";
            self.labType.textColor = redcolor;
            self.labType.layer.borderColor = redcolor.CGColor;
            self.labTeame.text = [NSString stringWithFormat:@"%@ vs %@",model.hometeam,model.guestteam];
            self.labRedNum.text = model.sort;
                        self.labRedStr.textColor = color66;
            if (!isNUll( self.labRedNum.text)) {
                self.labRedNum.attributedText = [RLSMethods withContent:self.labRedNum.text WithColorText:@"%" textColor:redcolor strFont:font17];
                if (model.type == 3) {
                    self.labRedStr.text = @"主胜误差";
                }else if (model.type == 0){
                    self.labRedStr.text = @"客胜误差";
                }else{
                    self.labRedStr.text = @"平局误差";
                }
            }else{
                self.labRedStr.text = @"";
            }
        }
            break;
        case 3:{
            if (model.league.length > 4) {
                self.labLeague.text = [NSString stringWithFormat:@"%@",[model.league substringToIndex:4]];
            }
            self.labType.text = @"盘王";
            self.labType.textColor = bluecolor;
            self.labType.layer.borderColor = bluecolor.CGColor;
            self.labTeame.text = model.teamname;
            self.labRedNum.text = model.maxname;
            self.labRedStr.textColor = color66;
            if (isNUll(self.labRedNum.text)) {
                self.labRedNum.attributedText = [RLSMethods withContent:self.labRedNum.text WithColorText:@"%" textColor:redcolor strFont:font17];
                self.labRedStr.text = model.name;
            }else{
                self.labRedStr.text = @"";
            }
        }
            break;
        default:
            break;
    }
    if (!_yro) {
        _yro = YES;
        [self setMas];
    }
}
- (void)setMas{
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [self.labType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.BGView.mas_left).offset(15);
        make.top.mas_equalTo(self.BGView.mas_top).offset(15);
        make.width.mas_offset(30);
        make.height.mas_offset(15);
    }];
    [self.labLeague mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labType.mas_left);
        make.top.mas_equalTo(self.labType.mas_bottom).offset(7.5);
    }];
        [self.labTeame mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.labType.mas_left);
            make.top.mas_equalTo(self.labType.mas_bottom).offset(7.5);
        }];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labType.mas_left);
        make.top.mas_equalTo(self.labTeame.mas_bottom).offset(6);
        make.width.mas_offset(210 * Scale_Ratio_width);
    }];
    [self.labBlackStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.BGView.mas_right).offset(-15);
        make.top.mas_equalTo(self.labBlackNum.mas_bottom).offset(7.5);
    }];
    [self.labBlackNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.labBlackStr.mas_centerX);
        make.top.mas_equalTo(self.BGView.mas_top).offset(36);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labBlackStr.mas_left).offset(-10);
        make.top.mas_equalTo(self.BGView.mas_top).offset(38);
        make.height.mas_offset(50);
        make.width.mas_offset(0.5);
    }];
    [self.labRedStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labBlackStr.mas_centerY);
        make.right.mas_equalTo(self.lineView.mas_left).offset(-10);
    }];
    [self.labRedNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.labRedStr.mas_centerX);
        make.top.mas_equalTo(self.labBlackNum.mas_top);
    }];
}
- (void)cellOneIndexPath:(NSInteger)row{
    if (row == 0) {
        [self.BGView addSubview:self.labRedNum];
        [self.BGView addSubview:self.labRedStr];
        [self.BGView addSubview:self.labBlackNum];
        [self.BGView addSubview:self.labBlackStr];
        [self.BGView addSubview:self.lineView];
        [self.labBlackStr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.BGView.mas_right).offset(-15);
            make.top.mas_equalTo(self.labBlackNum.mas_bottom).offset(7.5);
        }];
        [self.labBlackNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.labBlackStr.mas_centerX);
            make.top.mas_equalTo(self.BGView.mas_top).offset(36);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.labBlackStr.mas_left).offset(-10);
            make.top.mas_equalTo(self.BGView.mas_top).offset(38);
            make.height.mas_offset(50);
            make.width.mas_offset(0.5);
        }];
        [self.labRedStr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.labBlackStr.mas_centerY);
            make.right.mas_equalTo(self.lineView.mas_left).offset(-10);
        }];
        [self.labRedNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.labRedStr.mas_centerX);
            make.top.mas_equalTo(self.labBlackNum.mas_top);
        }];
    }else{
        [self.BGView addSubview:self.labRedNum];
        [self.BGView addSubview:self.labRedStr];
        [self.labRedStr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.BGView.mas_right).offset(-30);
            make.top.mas_equalTo(self.labRedNum.mas_bottom).offset(7.5);
            make.width.mas_offset(70);
        }];
        [self.labRedNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.labRedStr.mas_centerX);
            make.top.mas_equalTo(self.BGView.mas_top).offset(37.5);
        }];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
